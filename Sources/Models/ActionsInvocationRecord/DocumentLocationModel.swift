//
//  DocumentLocationModel.swift
//  
//
//  Created by woody on 2023/04/10.
//

import Foundation


struct DocumentLocationModel: Decodable {
    @PrimitiveTypeModel var concreteTypeName: String
    @PrimitiveTypeModel var url: URL?
}
