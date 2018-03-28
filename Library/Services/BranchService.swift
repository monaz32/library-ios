//
//  BranchService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BranchService {
    static let sharedService = BranchService()
    
    // get details on all branches
    func getBranches(completion: @escaping (Result<[LibraryBranch]>) -> Void) {
        APIClient.sharedClient.request(Router.getBranches) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let ratings = Mapper<LibraryBranch>().mapArray(JSONArray: json)
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
    
    // get information on a specific branch
    func getBranchWithID(id: Int, completion: @escaping (Result<LibraryBranch>) -> Void) {
        APIClient.sharedClient.request(Router.getBranchWithID(id: id)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let branches = Mapper<LibraryBranch>().mapArray(JSONArray: json)
                    // There is only one branch with the corresponding id, so we return
                    // the first element of the array.
                    completion(Result.success(branches[0]))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // get details on rooms at a specific branch
    func getRoomsAtBranch(id: Int, completion: @escaping (Result<[Room]>) -> Void) {
        APIClient.sharedClient.request(Router.getRoomsAtBranch(id: id)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let rooms = Mapper<Room>().mapArray(JSONArray: json)
                    completion(Result.success(rooms))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getRoomWithIDAtBranch(branchID: Int, roomNum: Int, completion: @escaping (Result<Room>) -> Void) {
        APIClient.sharedClient.request(Router.getRoomWithIDAtBranch(branchID: branchID, roomNum: roomNum)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let rooms = Mapper<Room>().mapArray(JSONArray: json)
                    // There is only one room with the corresponding ids, so we return
                    // the first element of the array.
                    completion(Result.success(rooms[0]))
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
