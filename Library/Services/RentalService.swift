//
//  RentalService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RentalService {
    static let sharedService = RentalService()
    
    // get details on all current rentals of a member
    func getCurrentRentalsOfMember(id: Int, completion: @escaping (Result<[Rental]>) -> Void) {
        APIClient.sharedClient.request(Router.getCurrentRentalsOfMember(id: id)) { (response) in
            self.listRentalHandler(response: response, completion: completion)
        }
    }
    
    // get details on all rentals of a member
    func getAllRentalsOfMember(id: Int, completion: @escaping (Result<[Rental]>) -> Void) {
        APIClient.sharedClient.request(Router.getAllRentalsOfMember(id: id)) { (response) in
            self.listRentalHandler(response: response, completion: completion)
        }
    }
    
    // add a new rental
    func addRental(memberID: Int, bookID: Int, fromTime: String, fromDate: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addRental(memberID: memberID, bookID: bookID, fromTime: fromTime, fromDate: fromDate)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // return a rental
    func returnRental(bookID: Int, returnTime: String, returnDate: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.returnRental(bookID: bookID, returnTime: returnTime, returnDate: returnDate)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // Utilities
    func listRentalHandler(response: Result<Any>, completion: @escaping (Result<[Rental]>) -> Void) {
        switch response {
        case .success(let result):
            if let json = result as? [[String: Any]] {
                let rentals = Mapper<Rental>().mapArray(JSONArray: json)
                completion(Result.success(rentals))
            }
            else {
                completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
            }
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}
