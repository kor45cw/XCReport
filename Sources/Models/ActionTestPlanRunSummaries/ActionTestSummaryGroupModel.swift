//
//  ActionTestSummaryGroupModel.swift
//  
//
//  Created by woody on 2023/04/11.
//

import Foundation


// super type: ActionTestSummaryIdentifiableObject < ActionAbstractTestSummary
struct ActionTestSummaryGroupModel: Decodable {
    let duration: Double?
    @PrimitiveTypeModel var identifier: String
    @PrimitiveTypeModel var name: String
    var testStatus: String?
    let subtests: [ActionTestSummaryGroupModel]?
    
    enum CodingKeys: CodingKey {
        case duration
        case identifier
        case name
        case testStatus
        case subtests
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let _duration = try container.decodeIfPresent(PrimitiveType.self, forKey: .duration)?.value
        if let _duration, let duration = Double(_duration) {
            self.duration = duration
        } else {
            self.duration = nil
        }
        self._identifier = try container.decode(PrimitiveTypeModel<String>.self, forKey: .identifier)
        self._name = try container.decode(PrimitiveTypeModel<String>.self, forKey: .name)
        self.testStatus = try container.decodeIfPresent(PrimitiveType.self, forKey: .testStatus)?.value
        self.subtests = try container.decodeIfPresent(ArrayType<ActionTestSummaryGroupModel>.self, forKey: .subtests)?.values
    }
}
