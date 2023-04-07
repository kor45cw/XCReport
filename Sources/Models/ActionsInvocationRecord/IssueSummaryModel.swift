//
//  IssueSummaryModel.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


struct IssueSummaryModel: Decodable {
    let documentLocationInCreatingWorkspace: DocumentLocationModel?
    @PrimitiveTypeModel var issueType: String
    @PrimitiveTypeModel var message: String
}
