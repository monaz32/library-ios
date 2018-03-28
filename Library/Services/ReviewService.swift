//
//  ReviewService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ReviewService {
    static let sharedService = ReviewService()
    
    // get all reviews on book with isbn
    func getReviews(isbn: String, completion: @escaping (Result<[ReviewDisplayed]>) -> Void) {
        APIClient.sharedClient.request(Router.getReviews(isbn: isbn)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let reviews = Mapper<ReviewDisplayed>().mapArray(JSONArray: json)
                    completion(Result.success(reviews))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // add a review
    func addReview(isbn: String, accountID: Int, rating: Int, review: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addReview(isbn: isbn, accountID: accountID, rating: rating, review: review)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
}

