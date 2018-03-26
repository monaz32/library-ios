//
//  BookService.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BookService {
    static let sharedService = BookService()
    
    func getBooks(title: String, author: String, publisher: String, genre: String, completion: @escaping (Result<[Book]>) -> Void) {
        APIClient.sharedClient.request(Router.getBooks(title: title, author: author, publisher: publisher, genre: genre)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let books = Mapper<Book>().mapArray(JSONArray: json)
                    completion(Result.success(books))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func addBook(isbn: String, title: String, author: String, publisher: String, genre: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addBook(isbn: isbn, title: title, author: author, publisher: publisher, genre: genre)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getBook(isbn: String, completion: @escaping (Result<Book>) -> Void) {
        APIClient.sharedClient.request(Router.getBook(isbn: isbn)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [String: Any], let book = Book(JSON: json) {
                    completion(Result.success(book))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
