//
//  Coverage.swift
//  
//
//  Created by woody on 2023/04/13.
//

import ArgumentParser
import Foundation

struct CoverageOptions: ParsableArguments {
    @Argument(help: ".xcresult file Path")
    var xcResultFile: String? = nil
    
    @Option(wrappedValue: 0, name: .shortAndLong, help: "print format type")
    var printFormat: Int
    
    @Flag(name: .shortAndLong, help: "Whether to print target coverage.")
    var targetCoverage = false
    
    @Flag(name: .shortAndLong, help: "Whether to print file coverage.")
    var fileCoverage = false
    
    @Flag(name: .shortAndLong, help: "Whether to print function coverage.")
    var callerCoverage = false
    
    @Flag(name: .shortAndLong, help: "Include extra information in the output.") // example --verbose => verbose = true
    var verbose = false
}

enum CoveragePrintOption: Int {
    case `default` = 0
    case markdown = 1
}

struct Coverage: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generates a code coverage report of Xcode test results.")
    
    @OptionGroup var options: CoverageOptions
    
    var filePath: String {
        options.xcResultFile ?? ""
    }
    
    var printFormat: CoveragePrintOption {
        CoveragePrintOption(rawValue: options.printFormat) ?? .default
    }
    
    func validate() throws {
        guard let xcResultFile = options.xcResultFile else {
            throw ValidationError("xcresult file path is Required")
        }
        
        if !FileManager.default.fileExists(atPath: xcResultFile) {
            throw ValidationError("'xcresult file path' does not exist")
        }
    }
    
    func run() throws {
        try runCodeCoverage()
    }
}

extension Coverage {
    func runCodeCoverage() throws {
        let output = try ShellCommand().setup(with: .codeCoverage(path: filePath)).run()
        
        let result = try JSONDecoder().decode(CodeCoverageModel.self, from: Data(output.utf8))
        totalCoverage(result)
        print(parseCodeCoverage(result))
    }
    
    func totalCoverage(_ input: CodeCoverageModel) {
        let coveredLines = input.targets.reduce(0, { $0 + $1.coveredLines })
        let executableLines = input.targets.reduce(0, { $0 + $1.executableLines })
        guard executableLines > 0 else {
            if printFormat == .default {
                print("Total Coverage: 0% (\(coveredLines)/\(executableLines))\n")
            } else if printFormat == .markdown {
                print("#Total Coverage: ![](https://progress-bar.dev/\(Int(round(0))) (\(coveredLines)/\(executableLines))<\\br>")
            }
            return
        }
        let fraction = Double(coveredLines) / Double(executableLines)
        let covPercent = fraction * 100
        if printFormat == .default {
            print("Total Coverage: \(covPercent)% (\(coveredLines)/\(executableLines))\n")
        } else if printFormat == .markdown {
            print("#Total Coverage: ![](https://progress-bar.dev/\(Int(round(covPercent))) (\(coveredLines)/\(executableLines))<\\br>")
        }
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
                var targetCoverage = ""
                if printFormat == .default {
                    targetCoverage = "\(target.name): \(percent)% (\(target.coveredLines)/\(target.executableLines))\n"
                } else if printFormat == .markdown {
                    targetCoverage = "- \(target.name): ![](https://progress-bar.dev/\(Int(round(percent))) (\(target.coveredLines)/\(target.executableLines))<\\br>"
                }
                
                lines.append(targetCoverage)
            }
            
            for file in target.files {
                let percent = file.lineCoverage * 100
                if options.fileCoverage {
                    var fileCoverage = ""
                    if printFormat == .default {
                        fileCoverage = "\(file.name): \(percent)% (\(file.coveredLines)/\(file.executableLines))\n"
                    } else if printFormat == .markdown {
                        fileCoverage = "- \(file.name): ![](https://progress-bar.dev/\(Int(round(percent))) (\(file.coveredLines)/\(file.executableLines))<\\br>"
                    }
                    lines.append(fileCoverage)
                }
                if options.callerCoverage {
                    for function in file.functions {
                        let percent = function.lineCoverage * 100
                        var functionCoverage = ""
                        if printFormat == .default {
                            functionCoverage = "\(function.name): \(percent)% (\(function.coveredLines)/\(function.executableLines)) \(function.executionCount) times\n"
                        } else if printFormat == .markdown {
                            functionCoverage = "- \(function.name): ![](https://progress-bar.dev/\(Int(round(percent))) (\(function.coveredLines)/\(function.executableLines)) \(function.executionCount) times<\\br>"
                        }
                        lines.append(functionCoverage)
                    }
                }
            }
        }
        return lines
    }
}
