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
    var adminStatus: Bool?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        ID          <- map["eid"]
        email       <- map["eEmail"]
        branchNum   <- map["branchnum"]
        SIN         <- map["sin"]
        name        <- map["ename"]
        address     <- map["eaddress"]
        phoneNumber <- map["ephonenumber"]
        adminStatus <- map["adminStatus"]
    }
}
