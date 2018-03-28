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
    func addLibraryBook(bookID: Int, isbn: String, branchNum: Int, status: Bool, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addLibraryBook(bookID: bookID, isbn: isbn, branchNum: branchNum, status: status)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // filter library books
    func getLibraryBooks(branchNum: Int, status: Bool, completion: @escaping (Result<[LibraryBook]>) -> Void) {
        APIClient.sharedClient.request(Router.getLibraryBooks(branchNum: branchNum, status: status)) { (response) in
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
    
    // todo: updateLibraryBook
}

