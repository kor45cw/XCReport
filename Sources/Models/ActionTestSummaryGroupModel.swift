//
//  ActionTestSummaryGroupModel.swift
//  
//
//  Created by woody on 2023/04/11.
//

import Foundation


// super type: ActionTestSummaryIdentifiableObject < ActionAbstractTestSummary
struct ActionTestSummaryGroupModel: Decodable {
    @PrimitiveTypeModel var duration: Double
    @PrimitiveTypeModel var identifier: String
    @PrimitiveTypeModel var name: String
    let subtests: [ActionTestSummaryGroupModel]
    
    enum CodingKeys: CodingKey {
        case duration
        case identifier
        case name
        case subtests
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._duration = try container.decode(PrimitiveTypeModel<Double>.self, forKey: .duration)
        self._identifier = try container.decode(PrimitiveTypeModel<String>.self, forKey: .identifier)
        self._name = try container.decode(PrimitiveTypeModel<String>.self, forKey: .name)
        self.subtests = try container.decode(ArrayType<ActionTestSummaryGroupModel>.self, forKey: .subtests).values
    }
}
