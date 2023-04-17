//
//  ResultMetricsModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation


struct ResultMetricsModel: Decodable {
    var errorCount: Int?
    var testsCount: Int?
    var testsFailedCount: Int?
    var warningCount: Int?
}
