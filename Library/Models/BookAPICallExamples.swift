//
//  BookAPICallExamples.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class BookAPICallExamples {
    
    // getBooks with filter
    func getBooks() {
        BookService.sharedService.getBooks(title: "", author: "Poe, Edgar Allen", publisher: "", genre: "") { (result) in
            let books = result.value!
            print(books)
        }
    }
    
    // add a book
    func addBook() {
        BookService.sharedService.addBook(isbn: "14", branchNum: 3, title: "testbook", author: "mz", publisher: "ubc", genre: "signal_processing", completion: { (result) in
            switch result {
            case .success:
                print("addBook success")
            case .failure:
                print("addBook failure")
            }
        })
    }
    
    // delete a book
    func deleteBook() {
        BookService.sharedService.deleteBook(isbn: "18") { (result) in
            print("deleteBook:")
            print(result)
        }
    }
    
    // update a book
    func updateBook() {
        BookService.sharedService.updateBook(isbn: "1000", title: "Story of Philosophy, The", author: "Durant, Will", publisher: "Pocket", genre: "signal_processing") { (result) in
            switch result {
            case .success:
                print("updateBook success")
            case .failure:
                print("updateBook failure")
            }
        }
    }
    
    // count number of books in a genre
    func genreCount() {
        BookService.sharedService.getBookGenreCount(completion: { (result) in
            switch result {
            case .success:
                print("getBookGenreCount success")
                let counts = result.value!
                for count in counts {
                    print("\(count.genre as String?): \(count.count as Int?)")
                }
            case .failure:
                print("getBookGenreCount failure")
            }
        })
    }
}
