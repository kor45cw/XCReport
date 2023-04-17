//
//  ResultMetricsModel+Decoder.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


extension ResultMetricsModel {
    enum CodingKeys: CodingKey {
        case errorCount
        case testsCount
        case testsFailedCount
        case warningCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let errorCountModel = try container.decodeIfPresent(PrimitiveType.self, forKey: .errorCount)
        self.errorCount = Int(errorCountModel?.value ?? "")
        
        
        let testsCountModel = try container.decodeIfPresent(PrimitiveType.self, forKey: .testsCount)
        self.testsCount = Int(testsCountModel?.value ?? "")
        
        let testsFailedCountModel = try container.decodeIfPresent(PrimitiveType.self, forKey: .testsFailedCount)
        self.testsFailedCount = Int(testsFailedCountModel?.value ?? "")

        let warningCountModel = try container.decodeIfPresent(PrimitiveType.self, forKey: .warningCount)
        self.warningCount = Int(warningCountModel?.value ?? "")
    }
}
