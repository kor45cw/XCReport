//
//  EntityIdentifierModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation


struct EntityIdentifierModel: Decodable {
    @PrimitiveTypeModel var containerName: String
    @PrimitiveTypeModel var entityName: String
    @PrimitiveTypeModel var entityType: String
    @PrimitiveTypeModel var sharedState: String
}
