//
//  NameModel.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


struct NameModel: Decodable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(PrimitiveType.self, forKey: .name).value
    }
}
