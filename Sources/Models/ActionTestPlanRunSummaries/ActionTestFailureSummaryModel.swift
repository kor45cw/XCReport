//
//  ActionTestFailureSummaryModel.swift
//  
//
//  Created by woody on 2023/04/14.
//

import Foundation


struct ActionTestFailureSummaryModel: Decodable {
    let message: String?
    let fileName: String?
    let lineNumber: Int?
    let isPerformanceFailure: Bool?
    @PrimitiveTypeModel var uuid: String
    let issueType: String?
    let detailedDescription: String?
//    let attachments: [ActionTestAttachment]?
//    let associatedError: TestAssociatedErrorModel?
//    let sourceCodeContext: SourceCodeContextModel?
    let timestamp: Date?
    @PrimitiveTypeModel var isTopLevelFailure: Bool
    
    enum CodingKeys: CodingKey {
        case message
        case fileName
        case lineNumber
        case isPerformanceFailure
        case uuid
        case issueType
        case detailedDescription
        case associatedError
        case sourceCodeContext
        case timestamp
        case isTopLevelFailure
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(PrimitiveType.self, forKey: .message)?.value
        self.fileName = try container.decodeIfPresent(PrimitiveType.self, forKey: .fileName)?.value
        let _lineNumber = try container.decodeIfPresent(PrimitiveType.self, forKey: .fileName)?.value
        if let _lineNumber, let value = Int(_lineNumber) {
            self.lineNumber = value
        } else {
            self.lineNumber = nil
        }
        let _isPerformanceFailure = try container.decodeIfPresent(PrimitiveType.self, forKey: .isPerformanceFailure)?.value
        if let _isPerformanceFailure  {
            self.isPerformanceFailure = _isPerformanceFailure == "true"
        } else {
            self.isPerformanceFailure = nil
        }
        self._uuid = try container.decode(PrimitiveTypeModel<String>.self, forKey: .uuid)
        self.issueType = try container.decodeIfPresent(PrimitiveType.self, forKey: .issueType)?.value
        self.detailedDescription = try container.decodeIfPresent(PrimitiveType.self, forKey: .detailedDescription)?.value
        let _timestamp = try container.decodeIfPresent(PrimitiveType.self, forKey: .timestamp)?.value
        if let _timestamp, let value = ISO8601DateFormatter().date(from: _timestamp) {
            self.timestamp = value
        } else {
            self.timestamp = nil
        }
        self._isTopLevelFailure = try container.decode(PrimitiveTypeModel<Bool>.self, forKey: .isTopLevelFailure)
    }
}


struct SourceCodeContextModel: Decodable {
    let location: SourceCodeLocationModel?
    let callStack: [SourceCodeFrameModel]
}

struct SourceCodeLocationModel: Decodable {
    let filePath: String?
    let lineNumber: Int?
}


struct SourceCodeFrameModel: Decodable {
    let addressString: String?
    let symbolInfo: SourceCodeSymbolInfoModel?
}

struct SourceCodeSymbolInfoModel: Decodable {
    let imageName: String?
    let symbolName: String?
    let location: SourceCodeLocationModel?
}


struct TestAssociatedErrorModel: Decodable {
    let domain: String?
    let code: Int?
    let userInfo: SortedKeyValueArrayModel?
}

struct SortedKeyValueArrayModel: Decodable {
    let storage: [SortedKeyValueArrayPairModel]
}

struct SortedKeyValueArrayPairModel: Decodable {
    
}
