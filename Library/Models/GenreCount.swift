//
//  GenreCount.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class GenreCount: Mappable {
    var genre: String?
    var count: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        genre   <- map["genre"]
        count   <- map["count"]
    }
}
