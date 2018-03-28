//
//  ReviewDisplayed
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class ReviewDisplayed: Mappable {
    var title: String?
    var rating: String?
    var review: String?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        title   <- map["title"]
        rating  <- map["rating"]
        review  <- map["review"]
        name    <- map["name"]
    }
}

