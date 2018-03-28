//
//  EventWithLocation.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class EventWithLocation: Mappable {
    var eventName: String?
    var branchName: String?
    var address: String?
    var phoneNumber: String?
    var fromDate: String?
    var toDate: String?
    var fromTime: String?
    var toTime: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        eventName   <- map["eventName"]
        branchName  <- map["branchName"]
        address     <- map["address"]
        phoneNumber <- map["phoneNum"]
        fromDate    <- map["fromDate"]
        toDate      <- map["toDate"]
        fromTime    <- map["fromTime"]
        toTime      <- map["toTime"]
    }
}


