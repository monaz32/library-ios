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
    
    func addBook(isbn: String, branchNum: Int, title: String, author: String, publisher: String, genre: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addBook(isbn: isbn, branchNum: branchNum, title: title, author: author, publisher: publisher, genre: genre)) { (response) in
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
                if let json = result as? [[String: Any]] {
                    let books = Mapper<Book>().mapArray(JSONArray: json)
                    // There is only one book with the corresponding isbn, so we return
                    // the first element of the array.
                    completion(Result.success(books[0]))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func updateBook(isbn: String, title: String, author: String, publisher: String, genre: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.updateBook(isbn: isbn, title: title, author: author, publisher: publisher, genre: genre)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func deleteBook(isbn: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.deleteBook(isbn: isbn)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getBookGenreCount(completion: @escaping (Result<[GenreCount]>) -> Void) {
        APIClient.sharedClient.request(Router.getBookGenreCount) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let genreCounts = Mapper<GenreCount>().mapArray(JSONArray: json)
                    completion(Result.success(genreCounts))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
