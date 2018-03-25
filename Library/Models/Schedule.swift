//
//  Schedule.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Schedule: Mappable {
    var accountID: Int?
    var roomName: String?
    var fromDate: String?
    var toDate: String?
    var fromTime: String?
    var toTime: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        accountID   <- map["accountID"]
        roomName    <- map["roomName"]
        fromDate    <- map["fromDate"]
        toDate      <- map["toDate"]
        fromTime    <- map["fromTime"]
        toTime      <- map["toTime"]
    }
}
