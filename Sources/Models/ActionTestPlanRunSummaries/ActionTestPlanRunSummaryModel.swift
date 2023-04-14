//
//  ActionTestPlanRunSummaryModel.swift
//  
//
//  Created by woody on 2023/04/11.
//

import Foundation


// super type: ActionAbstractTestSummaryModel
struct ActionTestPlanRunSummaryModel: Decodable {
    @PrimitiveTypeModel var name: String
    var testableSummaries: [ActionTestableSummaryModel]
    
    enum CodingKeys: CodingKey {
        case name
        case testableSummaries
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._name = try container.decode(PrimitiveTypeModel<String>.self, forKey: .name)
        self.testableSummaries = try container.decode(ArrayType<ActionTestableSummaryModel>.self, forKey: .testableSummaries).values
    }
}

