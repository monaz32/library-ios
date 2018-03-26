//
//  Employee.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Employee: Mappable {
    var ID: Int?
    var email: String?
    var SIN: String?
    var name: String?
    var address: String?
    var phoneNumber: String?
    var branchNum: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        ID          <- map["eID"]
        email       <- map["eEmail"]
        branchNum   <- map["branchNum"]
        SIN         <- map["SIN"]
        name        <- map["eName"]
        address     <- map["eAddress"]
        phoneNumber <- map["ePhoneNumber"]
    }
}
