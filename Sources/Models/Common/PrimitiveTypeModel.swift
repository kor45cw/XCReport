//
//  PrimitiveTypeModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation

@propertyWrapper
struct PrimitiveTypeModel<T: Decodable>: Decodable {
    var wrappedValue: T
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case value = "_value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .value)
        
        if T.self is Double.Type {
            wrappedValue = Double(value) as! T
        } else if T.self is Int.Type {
            wrappedValue = Int(value) as! T
        } else if T.self is Optional<URL>.Type {
            wrappedValue = URL(string: value) as! T
        } else if T.self is Date.Type {
            wrappedValue = (ISO8601DateFormatter().date(from: value) ?? Date()) as! T
        } else if T.self is Bool.Type {
            wrappedValue = (value == "true") as! T
        } else if T.self is String.Type {
            wrappedValue = value as! T
        } else {
            throw DecodingError.typeMismatch(T.self, .init(codingPath: [CodingKeys.value], debugDescription: "PrimitiveTypeModel does not support type"))
        }
    }
}
