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
        do {
            let output = try ShellCommand()
                .setup(with: .report(path: a()))
                .run()
            let json = Data(output.utf8)
            let decoder = JSONDecoder()
            let result = try decoder.decode(Output.self, from: json)
            print("output: \n\(result.type)")
        } catch {
            if options.verbose {
                print("--woody--", error.localizedDescription)
            }
        }
    }
}

struct Output: Decodable {
    let type: TypeNameModel
    let actions: ActionOutputModel
//    let issues: String
//    let metadataRef: String
//    let metrics: String
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case actions
//        case issuesr
//        case metadataRef
//        case metrics
    }
}

