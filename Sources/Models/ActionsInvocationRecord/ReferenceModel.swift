//
//  ReferenceModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation


struct ReferenceModel: Decodable {
    @PrimitiveTypeModel var id: String
    var targetType: String?
    
    enum CodingKeys: CodingKey {
        case id
        case targetType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(PrimitiveTypeModel<String>.self, forKey: .id)
        self.targetType = try container.decodeIfPresent(NameModel.self, forKey: .targetType)?.name
    }
}
