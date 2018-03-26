//
//  LibraryBook.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class LibraryBook: Mappable {
    var ID: Int?
    var isbn: String?
    var branchNum: Int?
    var status: Bool?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        isbn        <- map["isbn"]
        ID          <- map["bookID"]
        branchNum   <- map["branchNum"]
        status      <- map["status"]
    }
}
