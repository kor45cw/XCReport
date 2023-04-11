//
//  ShellCommand.swift
//  
//
//  Created by woody on 2023/04/06.
//

import Foundation


final class ShellCommand {
    enum Error: Swift.Error {
        case shellOutputFailed
    }
    
    enum CommandType {
        case invocation(path: String)
        case invocationMetaData(path: String, id: String)
        case testPlanRunSummary(path: String, id: String)
        case codeCoverage(path: String)

        var command: String {
            switch self {
            case let .invocation(path):
                return "xcrun xcresulttool get --format json --path \(path)"
            case let .invocationMetaData(path, id),
                let .testPlanRunSummary(path, id):
                return "xcrun xcresulttool get --format json --path \(path) --id \(id)"
            case let .codeCoverage(path):
                return "xcrun xccov view --report --json \(path)"
            }
        }
    }
    
    lazy var task: Process = {
        let process = Process()
        process.launchPath = "/bin/bash"
        process.arguments = ["-c"]
        return process
    }()
    
    lazy var pipe = Pipe()
    
    func setup(with type: CommandType) -> ShellCommand {
        task.arguments?.append(type.command)
        task.standardOutput = pipe
        task.launch()
        return self
    }
    
    func run() throws -> String {
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        
        guard let output = String(data: data, encoding: .utf8) else {
            throw Error.shellOutputFailed
        }
        
        return output
    }
}
