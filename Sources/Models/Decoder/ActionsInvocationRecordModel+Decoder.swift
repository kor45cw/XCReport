//
//  ActionsInvocationRecordModel+Decoder.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


extension ActionsInvocationRecordModel {
    
    enum CodingKeys: CodingKey {
        case actions
        case issues
        case metadataRef
        case metrics
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actions = try container.decode(ArrayType<ActionRecordModel>.self, forKey: .actions).values
        self.issues = try container.decode(ResultIssueSummariesModel.self, forKey: .issues)
        self.metadataRef = try container.decode(ReferenceModel.self, forKey: .metadataRef)
        self.metrics = try container.decode(ResultMetricsModel.self, forKey: .metrics)
    }

}
