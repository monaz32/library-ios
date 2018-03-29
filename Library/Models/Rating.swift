//
//  Rating.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Rating: Mappable {
    var isbn: String?
    var title: String?
    var average: Double?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        isbn    <- map["isbn"]
        title   <- map["title"]
        average <- map["average"]
    }
}

