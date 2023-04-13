//
//  Coverage.swift
//  
//
//  Created by woody on 2023/04/13.
//

import ArgumentParser
import Foundation

struct Coverage: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Generate a blog post banner from the given input")

    @OptionGroup var options: Options
    
    var filePath: String {
        options.xcResultFile ?? ""
    }
    
    func run() throws {
        try runCodeCoverage()
    }
    
    func runCodeCoverage() throws {
        let output = try ShellCommand().setup(with: .codeCoverage(path: filePath)).run()
        
        let result = try JSONDecoder().decode(CodeCoverageModel.self, from: Data(output.utf8))
        print("output: \(parseCodeCoverage(result).reduce("", { $0 + "\n\($1)" }))")
        
    }
    
    func parseCodeCoverage(_ input: CodeCoverageModel) -> [String] {
        var lines = [String]()
        var executableLines: Int = 0
        var coveredLines: Int = 0
        
        for target in input.targets {
            let percent = target.lineCoverage * 100
            executableLines += target.executableLines
            coveredLines += target.coveredLines
            
            if options.targetCoverage {
                lines.append(
                    "\(target.name): \(percent)% (\(target.coveredLines)/\(target.executableLines))"
                )
            }
            
            for file in target.files {
                let percent = file.lineCoverage * 100
                if options.fileCoverage {
                    lines.append(
                        "\(file.name): \(percent)% (\(file.coveredLines)/\(file.executableLines))"
                    )
                }
                if options.callerCoverage {
                    for function in file.functions {
                        let percent = function.lineCoverage * 100
                        lines.append(
                            "\(percent)% \(function.name):\(function.lineNumber)  (\(function.coveredLines)/\(function.executableLines)) \(function.executionCount) times"
                        )
                    }
                }
            }
        }
        
        guard executableLines > 0 else { return lines }
        let fraction = Double(coveredLines) / Double(executableLines)
        let covPercent = fraction * 100
        let line = "Total coverage: \(covPercent)% (\(coveredLines)/\(executableLines))"
        lines.insert(line, at: 1)
        return lines
    }
    
}




