//
//  ActionTestPlanRunSummariesModel.swift
//  
//
//  Created by woody on 2023/04/11.
//

import Foundation


struct ActionTestPlanRunSummariesModel: Decodable {
    var summaries: [ActionTestPlanRunSummaryModel]
    
    enum CodingKeys: CodingKey {
        case summaries
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.summaries = try container.decode(ArrayType<ActionTestPlanRunSummaryModel>.self, forKey: .summaries).values
    }
}
