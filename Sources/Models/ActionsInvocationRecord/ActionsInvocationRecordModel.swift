//
//  ActionsInvocationRecordModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation


struct ActionsInvocationRecordModel: Decodable {
    let actions: [ActionRecordModel]
    let issues: ResultIssueSummariesModel
    let metadataRef: ReferenceModel
    let metrics: ResultMetricsModel
}
