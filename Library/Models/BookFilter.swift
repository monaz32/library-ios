//
//  BookFilter.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation

class BookFilter {
    var title: String
    var author: String
    var publisher: String
    var genre: String
    
    init(title: String, author: String, publisher: String, genre: String) {
        self.title = title
        self.author = author
        self.publisher = publisher
        self.genre = genre 
    }
}
