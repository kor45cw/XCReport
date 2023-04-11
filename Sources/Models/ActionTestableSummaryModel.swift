//
//  ActionTestableSummaryModel.swift
//  
//
//  Created by woody on 2023/04/11.
//

import Foundation

// super type:
struct ActionTestableSummaryModel: Decodable {
    @PrimitiveTypeModel var diagnosticsDirectoryName: String
    @PrimitiveTypeModel var identifierURL: URL?
    @PrimitiveTypeModel var name: String
    @PrimitiveTypeModel var projectRelativePath: String
    @PrimitiveTypeModel var targetName: String
    @PrimitiveTypeModel var testKind: String
    @PrimitiveTypeModel var testLanguage: String
    @PrimitiveTypeModel var testRegion: String
    let tests: [ActionTestSummaryGroupModel]
    
    enum CodingKeys: CodingKey {
        case diagnosticsDirectoryName
        case identifierURL
        case name
        case projectRelativePath
        case targetName
        case testKind
        case testLanguage
        case testRegion
        case tests
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._diagnosticsDirectoryName = try container.decode(PrimitiveTypeModel<String>.self, forKey: .diagnosticsDirectoryName)
        self._identifierURL = try container.decode(PrimitiveTypeModel<URL?>.self, forKey: .identifierURL)
        self._name = try container.decode(PrimitiveTypeModel<String>.self, forKey: .name)
        self._projectRelativePath = try container.decode(PrimitiveTypeModel<String>.self, forKey: .projectRelativePath)
        self._targetName = try container.decode(PrimitiveTypeModel<String>.self, forKey: .targetName)
        self._testKind = try container.decode(PrimitiveTypeModel<String>.self, forKey: .testKind)
        self._testLanguage = try container.decode(PrimitiveTypeModel<String>.self, forKey: .testLanguage)
        self._testRegion = try container.decode(PrimitiveTypeModel<String>.self, forKey: .testRegion)
        self.tests = try container.decode(ArrayType<ActionTestSummaryGroupModel>.self, forKey: .tests).values
    }
}
