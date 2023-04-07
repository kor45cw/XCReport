//
//  ResultIssueSummariesModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation


struct ResultIssueSummariesModel: Decodable {
    let errorSummaries: [IssueSummaryModel]?
    let warningSummaries: [IssueSummaryModel]?
}

