//
//  LibraryBookService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class LibraryBookService {
    static let sharedService = LibraryBookService()
    
    // add a library book
    func addLibraryBook(isbn: String, branchNum: Int, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addLibraryBook(isbn: isbn, branchNum: branchNum)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // filter library books
    func getLibraryBooks(isbn: String, completion: @escaping (Result<[LibraryBook]>) -> Void) {
        APIClient.sharedClient.request(Router.getLibraryBooks(isbn: isbn)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let books = Mapper<LibraryBook>().mapArray(JSONArray: json)
                    completion(Result.success(books))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // get a library book with specified id
    func getLibraryBook(id: Int, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.getLibraryBook(id: id)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // delete a library book
    func deleteLibraryBook(id: Int, completion: @escaping (Result<LibraryBook>) -> Void) {
        APIClient.sharedClient.request(Router.deleteLibraryBook(id: id)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let books = Mapper<LibraryBook>().mapArray(JSONArray: json)
                    // There is only one book with the corresponding id, so we return
                    // the first element of the array.
                    completion(Result.success(books[0]))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // get number of each book at the library
    func getLibraryBookCount(completion: @escaping (Result<Int>) -> Void) {
        APIClient.sharedClient.request(Router.getLibraryBookCount) { (response) in
            switch response {
            case .success(let result):
                // Note that result is an array. This casting works because result is guaranteed
                // to contain only one object with {"Count": count}
                if let result =  result as? [[String: Any]], let count = result[0]["Count"] as? Int {
                    completion(Result.success(count))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
        
    }
}

