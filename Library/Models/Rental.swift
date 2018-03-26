//
//  Rental.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Rental: Mappable {
    var ID: Int?
    var status: Bool?
    var bookID: Int?
    var accountID: Int?
    var fromDate: String?
    var toDate: String?
    var fromTime: String?
    var toTime: String?
    var returnDate: String?
    var returnTime: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        ID          <- map["rentalID"]
        status      <- map["status"]
        bookID      <- map["bookID"]
        accountID    <- map["accountID"]
        fromDate    <- map["fromDate"]
        toDate      <- map["toDate"]
        fromTime    <- map["fromTime"]
        toTime      <- map["toTime"]
        returnDate  <- map["returnDate"]
        returnTime  <- map["returnTime"]
    }
}
