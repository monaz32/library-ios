//
//  Review.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Review: Mappable {
    var accountID: Int?
    var isbn: String?
    var rating: Int?
    var review: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        accountID   <- map["accountID"]
        isbn        <- map["isbn"]
        rating      <- map["rating"]
        review      <- map["review"]
    }
}
