//
//  CodeCoverageInfoModel+Decoder.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


extension CodeCoverageInfoModel {
    enum CodingKeys: CodingKey {
        case hasCoverageData
        case archiveRef
        case reportRef
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let _hasCoverageData = try container.decodeIfPresent(PrimitiveType.self, forKey: .hasCoverageData)
        if let _hasCoverageData {
            self.hasCoverageData = _hasCoverageData.value == "true"
        } else {
            self.hasCoverageData = nil
        }
        self.archiveRef = try container.decodeIfPresent(ReferenceModel.self, forKey: .archiveRef)
        self.reportRef = try container.decodeIfPresent(ReferenceModel.self, forKey: .reportRef)
    }
}
