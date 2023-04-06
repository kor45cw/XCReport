//
//  TypeNameModel.swift
//  
//
//  Created by woody on 2023/04/06.
//

import Foundation


struct TypeNameModel: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "_name"
    }
}

