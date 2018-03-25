//
//  Room.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Room: Mappable {
    var roomName: String?
    var roomNumber: Int?
    var branchNum: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        roomName    <- map["roomName"]
        roomNumber  <- map["roomNumber"]
        branchNum   <- map["branchNum"]
    }
}
