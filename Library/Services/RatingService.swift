//
//  RatingService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RatingService {
    static let sharedService = RatingService()
    
    // get ratings grouped by isbn sorted from highest to lowest
    func getMAXRating(completion: @escaping (Result<[Rating]>) -> Void) {
        APIClient.sharedClient.request(Router.getMAXRating) { (response) in
            self.listResultHandler(response: response, completion: completion)
        }
    }
    
    // get ratings grouped by isbn sorted from lowest to highest
    func getMINRating(completion: @escaping (Result<[Rating]>) -> Void) {
        APIClient.sharedClient.request(Router.getMINRating) { (response) in
            self.listResultHandler(response: response, completion: completion)
        }
    }
    
    // get the average rating of a book
    func getAVRRating(isbn: String, completion: @escaping (Result<Int>) -> Void) {
        APIClient.sharedClient.request(Router.getAVRRating(isbn: isbn)) { (response) in
            switch response {
            case .success(let result):
                // Note that result is an array. This casting works because result is guaranteed
                // to contain only one object with {"rating": rating}
                if let result = result as? [[String: Any]] {
                    if let rating = result[0]["rating"] as? Int {
                        completion(Result.success(rating))
                    } else {
                        // Book has no average rating. Pass invalid value.
                        completion(Result.success(-1))
                    }
                } else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    
    // Utilities
    func listResultHandler(response: Result<Any>, completion: @escaping (Result<[Rating]>) -> Void) {
        switch response {
        case .success(let result):
            if let json = result as? [[String: Any]] {
                let ratings = Mapper<Rating>().mapArray(JSONArray: json)
                completion(Result.success(ratings))
            }
            else {
                completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
            }
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}
