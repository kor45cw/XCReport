//
//  ActionRecordModel.swift
//  
//
//  Created by woody on 2023/04/06.
//

import Foundation

struct ActionRecordModel: Decodable {
    let actionResult: ActionResultModel
    let buildResult: ActionResultModel
    @PrimitiveTypeModel var endedTime: Date
    let runDestination: ActionRunDestinationRecordModel
    @PrimitiveTypeModel var schemeCommandName: String
    @PrimitiveTypeModel var schemeTaskName: String
    @PrimitiveTypeModel var startedTime: Date
    @PrimitiveTypeModel var testPlanName: String
    @PrimitiveTypeModel var title: String
    
}

struct ActionResultModel: Decodable {
    let coverage: CodeCoverageInfoModel
    let diagnosticsRef: ReferenceModel?
    let issues: ResultIssueSummariesModel
    let logRef: ReferenceModel
    let metrics: ResultMetricsModel
    @PrimitiveTypeModel var resultName: String
    @PrimitiveTypeModel var status: String
}



struct ActionRunDestinationRecordModel: Decodable {
    @PrimitiveTypeModel var displayName: String
    let localComputerRecord: ActionDeviceRecordModel
    @PrimitiveTypeModel var targetArchitecture: String
    let targetDeviceRecord: ActionDeviceRecordModel
    let targetSDKRecord: ActionSDKRecordModel
}

struct ActionDeviceRecordModel: Decodable {
    @PrimitiveTypeModel var busSpeedInMHz: Int
    @PrimitiveTypeModel var cpuCount: Int
    var cpuKind: String?
    @PrimitiveTypeModel var cpuSpeedInMHz: Int
    @PrimitiveTypeModel var identifier: String
    @PrimitiveTypeModel var isConcreteDevice: Bool
    @PrimitiveTypeModel var logicalCPUCoresPerPackage: Int
    @PrimitiveTypeModel var modelCode: String
    @PrimitiveTypeModel var modelName: String
    @PrimitiveTypeModel var modelUTI: String
    @PrimitiveTypeModel var name: String
    @PrimitiveTypeModel var nativeArchitecture: String
    @PrimitiveTypeModel var operatingSystemVersion: String
    @PrimitiveTypeModel var operatingSystemVersionWithBuildNumber: String
    @PrimitiveTypeModel var physicalCPUCoresPerPackage: Int
    let platformRecord: ActionPlatformRecordModel
    @PrimitiveTypeModel var ramSizeInMegabytes: Int
}

struct ActionPlatformRecordModel: Decodable {
    @PrimitiveTypeModel var identifier: String
    @PrimitiveTypeModel var userDescription: String
}

struct ActionSDKRecordModel: Decodable {
    @PrimitiveTypeModel var identifier: String
    @PrimitiveTypeModel var name: String
    @PrimitiveTypeModel var operatingSystemVersion: String
}

struct CodeCoverageInfoModel: Decodable {
    let hasCoverageData: Bool?
}


extension ActionDeviceRecordModel {
    enum CodingKeys: CodingKey {
        case busSpeedInMHz
        case cpuCount
        case cpuKind
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._busSpeedInMHz = try container.decode(PrimitiveTypeModel<Int>.self, forKey: .busSpeedInMHz)
        self._cpuCount = try container.decode(PrimitiveTypeModel<Int>.self, forKey: .cpuCount)
        self.cpuKind = try container.decodeIfPresent(PrimitiveType.self, forKey: .cpuKind)?.value
        self._cpuSpeedInMHz = try container.decode(PrimitiveTypeModel<Int>.self, forKey: .cpuSpeedInMHz)
        self._identifier = try container.decode(PrimitiveTypeModel<String>.self, forKey: .identifier)
        self._isConcreteDevice = try container.decode(PrimitiveTypeModel<Bool>.self, forKey: .isConcreteDevice)
        self._logicalCPUCoresPerPackage = try container.decode(PrimitiveTypeModel<Int>.self, forKey: .logicalCPUCoresPerPackage)
        self._modelCode = try container.decode(PrimitiveTypeModel<String>.self, forKey: .modelCode)
        self._modelName = try container.decode(PrimitiveTypeModel<String>.self, forKey: .modelName)
        self._modelUTI = try container.decode(PrimitiveTypeModel<String>.self, forKey: .modelUTI)
        self._name = try container.decode(PrimitiveTypeModel<String>.self, forKey: .name)
        self._nativeArchitecture = try container.decode(PrimitiveTypeModel<String>.self, forKey: .nativeArchitecture)
        self._operatingSystemVersion = try container.decode(PrimitiveTypeModel<String>.self, forKey: .operatingSystemVersion)
        self._operatingSystemVersionWithBuildNumber = try container.decode(PrimitiveTypeModel<String>.self, forKey: .operatingSystemVersionWithBuildNumber)
        self._physicalCPUCoresPerPackage = try container.decode(PrimitiveTypeModel<Int>.self, forKey: .physicalCPUCoresPerPackage)
        self.platformRecord = try container.decode(ActionPlatformRecordModel.self, forKey: .platformRecord)
        self._ramSizeInMegabytes = try container.decode(PrimitiveTypeModel<Int>.self, forKey: .ramSizeInMegabytes)
    }
}
