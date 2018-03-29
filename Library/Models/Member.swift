//
//  Members.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Member: Mappable {
    var ID: Int?
    var email: String?
    var name: String?
    var phoneNumber: String?
    var fines: Double?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        ID          <- map["accountID"]
        email       <- map["email"]
        name        <- map["name"]
        phoneNumber <- map["phoneNum"]
        fines       <- map["fines"]
    }
}
