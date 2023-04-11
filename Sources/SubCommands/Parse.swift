//
//  Parse.swift
//  
//
//  Created by woody on 2023/04/06.
//

import ArgumentParser
import Foundation

struct Options: ParsableArguments {
    @Argument(
            help: ".xcresult file Path",
            completion: .file(),
            transform: URL.init(fileURLWithPath:)
    )
    var xcResultFile: URL? = nil
    
    @Flag(help: "Include extra information in the output.")
    var verbose = false
}

struct Parse: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate a blog post banner from the given input")
    
    @OptionGroup var options: Options
    
    func a() -> String {
        guard let inputFile = options.xcResultFile,
              let enumerator = FileManager.default.enumerator(
                  at: inputFile,
                  includingPropertiesForKeys: [.nameKey],
                  options: [.skipsHiddenFiles, .skipsPackageDescendants],
                  errorHandler: nil)
            else {
            return ""
        }
        
        var target: URL?
        for case let url as URL in enumerator where url.isFileURL {
            target = url
            break
        }
        return target?.deletingLastPathComponent().absoluteString.replacingOccurrences(of: "file://", with: "") ?? ""

    }
    
    mutating func run() {
        runCodeCoverage()
    }
    
    func runInvocation() {
        do {
            let output = try ShellCommand()
                .setup(with: .invocation(path: a()))
                .run()
            let result = try JSONDecoder().decode(ActionsInvocationRecordModel.self, from: Data(output.utf8))
            print("output: \n\(result.metrics.errorCount)")
        } catch {
            if options.verbose {
                print("--woody--", error.localizedDescription)
            }
        }
    }
    
    func runTestPlanRunSummary(id: String) {
        do {
            let output = try ShellCommand()
                .setup(with: .testPlanRunSummary(path: a(), id: id))
                .run()
            let result = try JSONDecoder().decode(ActionTestPlanRunSummaryModel.self, from: Data(output.utf8))
            print("output: \n\(result.testableSummaries.count)")
        } catch {
            if options.verbose {
                print("--woody--", error.localizedDescription)
            }
        }
    }
    
    func runCodeCoverage() {
        do {
            let output = try ShellCommand()
                .setup(with: .codeCoverage(path: a()))
                .run()
            let result = try JSONDecoder().decode(CodeCoverageModel.self, from: Data(output.utf8))
            print("""
                  output: \(result.coveredLines)
                  \(result.lineCoverage), \(result.executableLines)
                  \(result.targets.first!.name)
                  """)
        } catch {
            if options.verbose {
                print("--woody--", error.localizedDescription)
            }
        }
    }
}
