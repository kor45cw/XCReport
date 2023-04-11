//
//  CodeCoverageModel.swift
//  
//
//  Created by woody on 2023/04/11.
//

import Foundation


public struct CodeCoverageModel: Decodable {
    let coveredLines: Int
    let lineCoverage: Double
    let executableLines: Int
    let targets: [CodeCoverageTargetModel]
}

struct CodeCoverageTargetModel: Decodable {
    let coveredLines: Int
    let lineCoverage: Double
    let name: String
    let executableLines: Int
    let buildProductPath: String
    let files: [CodeCoverageFileModel]
}

struct CodeCoverageFileModel: Decodable {
    let coveredLines: Int
    let lineCoverage: Double
    let path: String
    let name: String
    let executableLines: Int
    let functions: [CodeCoverageFileFunctionModel]
}

struct CodeCoverageFileFunctionModel: Decodable {
    let coveredLines: Int
    let lineCoverage: Double
    let lineNumber: Int
    let name: String
    let executableLines: Int
    let executionCount: Int
}
