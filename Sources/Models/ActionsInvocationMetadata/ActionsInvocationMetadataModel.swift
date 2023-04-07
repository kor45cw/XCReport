//
//  ActionsInvocationMetadataModel.swift
//  
//
//  Created by woody on 2023/04/07.
//

import Foundation



struct ActionsInvocationMetadataModel: Decodable {
    @PrimitiveTypeModel var creatingWorkspaceFilePath: String
    var schemeIdentifier: EntityIdentifierModel
    @PrimitiveTypeModel var uniqueIdentifier: String
}
