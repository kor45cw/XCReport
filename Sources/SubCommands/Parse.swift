//
//  Parse.swift
//  
//
//  Created by woody on 2023/04/06.
//

import ArgumentParser
import Foundation

struct ParseOptions: ParsableArguments {
    @Argument(help: ".xcresult file Path")
    var xcResultFile: String? = nil
    
    @Flag(name: .shortAndLong, help: "Include extra information in the output.") // example --verbose => verbose = true
    var verbose = false
}

struct Parse: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generates a test report of Xcode test results.")
    
    @OptionGroup var options: ParseOptions
    
    func validate() throws {
        guard let xcResultFile = options.xcResultFile else {
            throw ValidationError("xcresult file path is Required")
        }
        
        if !FileManager.default.fileExists(atPath: xcResultFile) {
            throw ValidationError("'xcresult file path' does not exist")
        }
    }
    
    func run() throws {
        try runInvocation()
    }
    
    var filePath: String {
        options.xcResultFile ?? ""
    }
    
    func runInvocation() throws {
        let output = try ShellCommand()
            .setup(with: .invocation(path: filePath))
            .run()
        let result = try JSONDecoder().decode(ActionsInvocationRecordModel.self, from: Data(output.utf8))
        
        print("error: \(result.metrics.errorCount ?? 0), test: \(result.metrics.testsCount ?? 0), warning: \(result.metrics.warningCount ?? 0)")
        
        try checkBuildStatus(result.actions)
        
        for action in result.actions {
            if let id = action.actionResult.testsRef?.id {
                try runTestPlanRunSummary(id: id)
            }
        }
    }
    
    func runTestPlanRunSummary(id: String) throws {
        let output = try ShellCommand()
            .setup(with: .testPlanRunSummary(path: filePath, id: id))
            .run()
        let result = try JSONDecoder().decode(ActionTestPlanRunSummariesModel.self, from: Data(output.utf8))
        var totalDuration: Double = 0
        result.summaries.first?.testableSummaries.forEach {
//            print("\($0.name) result: \($0.tests.compactMap(\.duration).reduce(0, +))")
            totalDuration += $0.tests.compactMap(\.duration).reduce(0, +)
            // TODO: find failed Test
        }
        
        print("Total Test Duration: \(totalDuration)")
    }
}

enum StatusType: String {
    case failed
    case succeeded
}

enum ParseError: Error {
    case buildError
    case testError
}

private extension Parse {
    private func checkBuildStatus(_ inputs: [ActionRecordModel]) throws {
        for action in inputs {
            let buildResult = StatusType(rawValue: action.buildResult.status) ?? .failed
            let actionResult = StatusType(rawValue: action.actionResult.status) ?? .failed
            if buildResult == .failed {
                throw ParseError.buildError
            }
            if actionResult == .failed {
                throw ParseError.testError
            }
        }
    }
}
