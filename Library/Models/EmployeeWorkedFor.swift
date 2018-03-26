//
//  EmployeeWorkedFor.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class EmployeeWorkedFor: Mappable {
    var ID: Int?
    var branchNum: Int?
    var fromDate: String?
    var toDate: String?
    var fromTime: String?
    var toTime: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        ID          <- map["eID"]
        branchNum   <- map["branchNum"]
        fromDate    <- map["fromDate"]
        toDate      <- map["toDate"]
        fromTime    <- map["fromTime"]
        toTime      <- map["toTime"]
    }
}
