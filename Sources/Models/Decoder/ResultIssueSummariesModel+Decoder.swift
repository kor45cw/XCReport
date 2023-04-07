//
//  ResultIssueSummariesModel+Decoder.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


extension ResultIssueSummariesModel {
    enum CodingKeys: CodingKey {
        case errorSummaries
        case warningSummaries
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let _errorSummaries = try container.decodeIfPresent(ArrayType<IssueSummaryModel>.self, forKey: .errorSummaries)
        self.errorSummaries = _errorSummaries?.values
        
        
        let _warningSummaries = try container.decodeIfPresent(ArrayType<IssueSummaryModel>.self, forKey: .warningSummaries)
        self.warningSummaries = _warningSummaries?.values
    }
}
