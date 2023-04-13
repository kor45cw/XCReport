//
//  Parse.swift
//  
//
//  Created by woody on 2023/04/06.
//

import ArgumentParser
import Foundation

struct Options: ParsableArguments {
    @Argument(help: ".xcresult file Path")
    var xcResultFile: String? = nil
    
    @Flag(name: .shortAndLong, help: "Whether to print target coverage.")
    var targetCoverage = false
    
    @Flag(name: .shortAndLong, help: "Whether to print file coverage.")
    var fileCoverage = false
    
    @Flag(name: .shortAndLong, help: "Whether to print function coverage.")
    var callerCoverage = false
    
    @Flag(name: .shortAndLong, help: "Include extra information in the output.") // example --verbose => verbose = true
    var verbose = false
}

struct Parse: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate a blog post banner from the given input")
    
    @OptionGroup var options: Options
    
    func validate() throws {
        guard let xcResultFile = options.xcResultFile else {
            throw ValidationError("xcresult file path is Required")
        }
        
        if !FileManager.default.fileExists(atPath: xcResultFile) {
            throw ValidationError("'xcresult file path' does not exist")
        }
    }
    
    func run() throws {
        runInvocation()
    }
    
    var filePath: String {
        options.xcResultFile ?? ""
    }
    
    func runInvocation() {
        do {
            let output = try ShellCommand()
                .setup(with: .invocation(path: filePath))
                .run()
            let result = try JSONDecoder().decode(ActionsInvocationRecordModel.self, from: Data(output.utf8))
            
            print("metrics: error: \(result.metrics.errorCount ?? 0), test: \(result.metrics.testsCount ?? 0), warning: \(result.metrics.warningCount ?? 0)")
            print("build status: \(result.actions.first?.buildResult.status ?? "")")
            print("action status: \(result.actions.first?.actionResult.status ?? "")")
            
            for action in result.actions {
                if let id = action.actionResult.testsRef?.id {
                    runTestPlanRunSummary(id: id)
                }
            }
        } catch {
            if options.verbose {
                print("--woody--", error.localizedDescription)
            }
        }
    }
    
    func runTestPlanRunSummary(id: String) {
        do {
            let output = try ShellCommand()
                .setup(with: .testPlanRunSummary(path: filePath, id: id))
                .run()
            let result = try JSONDecoder().decode(ActionTestPlanRunSummariesModel.self, from: Data(output.utf8))
            result.summaries.first?.testableSummaries.forEach {
                print("\($0.name) result: \($0.tests.compactMap(\.duration).reduce(0, +))")
                // TODO: find failed Test
                
            }
        } catch {
            if options.verbose {
                print("--woody--", error.localizedDescription)
            }
        }
    }
    
    
}
