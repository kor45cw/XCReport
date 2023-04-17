//
//  IssueSummaryModel.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


struct IssueSummaryModel: Decodable {
    let documentLocationInCreatingWorkspace: DocumentLocationModel?
    @PrimitiveTypeModel var issueType: String
    @PrimitiveTypeModel var message: String
    var testCaseName: String?
    
    enum CodingKeys: CodingKey {
        case documentLocationInCreatingWorkspace
        case issueType
        case message
        case testCaseName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.documentLocationInCreatingWorkspace = try container.decodeIfPresent(DocumentLocationModel.self, forKey: .documentLocationInCreatingWorkspace)
        self._issueType = try container.decode(PrimitiveTypeModel<String>.self, forKey: .issueType)
        self._message = try container.decode(PrimitiveTypeModel<String>.self, forKey: .message)
        self.testCaseName = try container.decodeIfPresent(PrimitiveType.self, forKey: .testCaseName)?.value
    }
}
