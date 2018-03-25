//
//  LibraryBook.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class LibraryBranch: Mappable {
    var branchNum: Int?
    var name: String?
    var address: String?
    var phoneNumber: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        branchNum   <- map["branchNum"]
        name        <- map["name"]
        address     <- map["address"]
        phoneNumber <- map["phoneNum"]
    }
}
