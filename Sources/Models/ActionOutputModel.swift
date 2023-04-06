//
//  ActionOutputModel.swift
//  
//
//  Created by woody on 2023/04/06.
//

import Foundation


struct ActionOutputModel: Decodable {
    let type: TypeNameModel
    let values: [ActionOutputValueModel]
    
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case values = "_values"
    }
}

struct ActionOutputValueModel: Decodable {
    let type: TypeNameModel
//    let actionResult: String
//    let buildResult: String
    let endedTime: PrimitiveTypeModel
//    let runDestination: String
    let schemeCommandName: PrimitiveTypeModel
    let schemeTaskName: PrimitiveTypeModel
    let startedTime: PrimitiveTypeModel
    let testPlanName: PrimitiveTypeModel
    let title: PrimitiveTypeModel
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
//        case actionResult
//        case buildResult
        case endedTime
//        case runDestination
        case schemeCommandName
        case schemeTaskName
        case startedTime
        case testPlanName
        case title
    }
}

extension ActionOutputValueModel {
    
    struct RunDestinationModel: Decodable {
        let type: TypeNameModel
        let displayName: PrimitiveTypeModel
        let localComputerRecord: String
        let targetArchitecture: PrimitiveTypeModel
        let targetDeviceRecord: DeviceRecord
        let targetSDKRecord: SDKRecordModel
        
        enum CodingKeys: String, CodingKey {
            case type = "_type"
            case displayName
            case localComputerRecord
            case targetArchitecture
            case targetDeviceRecord
            case targetSDKRecord
        }
    }
    
    struct DeviceRecord: Decodable {
        let type: TypeNameModel
        let busSpeedInMHz: PrimitiveTypeModel
        let cpuCount: PrimitiveTypeModel
        let cpuSpeedInMHz: PrimitiveTypeModel
        let identifier: PrimitiveTypeModel
        let isConcreteDevice: PrimitiveTypeModel
        let logicalCPUCoresPerPackage: PrimitiveTypeModel
        let modelCode: PrimitiveTypeModel
        let modelName: PrimitiveTypeModel
        let modelUTI: PrimitiveTypeModel
        let name: PrimitiveTypeModel
        let nativeArchitecture: PrimitiveTypeModel
        let operatingSystemVersion: PrimitiveTypeModel
        let operatingSystemVersionWithBuildNumber: PrimitiveTypeModel
        let physicalCPUCoresPerPackage: PrimitiveTypeModel
        let platformRecord: PlatformRecordModel
        let ramSizeInMegabytes: PlatformRecordModel
        
        enum CodingKeys: String, CodingKey {
            case type = "_type"
            case busSpeedInMHz
            case cpuCount
            case cpuSpeedInMHz
            case identifier
            case isConcreteDevice
            case logicalCPUCoresPerPackage
            case modelCode
            case modelName
            case modelUTI
            case name
            case nativeArchitecture
            case operatingSystemVersion
            case operatingSystemVersionWithBuildNumber
            case physicalCPUCoresPerPackage
            case platformRecord
            case ramSizeInMegabytes
        }
    }
    struct PlatformRecordModel: Decodable {
        let type: TypeNameModel
        let identifier: PrimitiveTypeModel
        let userDescription: PrimitiveTypeModel
        
        enum CodingKeys: String, CodingKey {
            case type = "_type"
            case identifier
            case userDescription
        }
    }
    
    struct SDKRecordModel: Decodable {
        let type: TypeNameModel
        let identifier: PrimitiveTypeModel
        let name: PrimitiveTypeModel
        let operatingSystemVersion: PrimitiveTypeModel
        
        enum CodingKeys: String, CodingKey {
            case type = "_type"
            case identifier
            case name
            case operatingSystemVersion
        }
    }
    
    
    
    struct PrimitiveTypeModel: Decodable {
        let type: TypeNameModel
        let value: String
        
        var stringValue: String {
            value
        }
        
        var intValue: Int? {
            Int(value)
        }
        
        var boolValue: Bool {
            value == "true"
        }
        
        var dateValue: Date? {
            try? Date(value, strategy: .iso8601)
        }
        
        enum CodingKeys: String, CodingKey {
            case type = "_type"
            case value = "_value"
        }
    }
}
