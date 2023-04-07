//
//  PrimitiveType.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


struct PrimitiveType: Decodable {
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "_value"
    }
}
