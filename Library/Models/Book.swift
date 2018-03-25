//
//  Book.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Book: Mappable {
    var isbn: String?
    var title: String?
    var author: String?
    var publisher: String?
    var genre: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        isbn    <- map["isbn"]
        title         <- map["title"]
        author      <- map["author"]
        publisher      <- map["publisher"]
        genre       <- map["genre"]
    }
}
