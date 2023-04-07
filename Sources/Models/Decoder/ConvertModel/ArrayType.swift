//
//  ArrayType.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


struct ArrayType<T: Decodable>: Decodable {
    var values: [T]
    
    enum CodingKeys: String, CodingKey {
        case values = "_values"
    }
}
