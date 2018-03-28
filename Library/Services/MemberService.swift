//
//  MemberService.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MemberService {
    static let sharedService = MemberService()
    
    func memberLogin(email: String, password: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.memberLogin(email: email, password: password)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]], let id = json[0]["accountID"] as? String {
                    UserDefaults.standard.set(id, forKey: "id")
                    completion(Result.success(true))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getMembers(completion: @escaping (Result<[Member]>) -> Void) {
        APIClient.sharedClient.request(Router.getMembers) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let members = Mapper<Member>().mapArray(JSONArray: json)
                    completion(Result.success(members))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func addMember(phoneNum: String, email: String, name: String, password: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addMember(phoneNum: phoneNum, email: email, name: name, password: password)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getMember(id: Int, completion: @escaping (Result<Member>) -> Void) {
        APIClient.sharedClient.request(Router.getMember(id: id)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let member = Mapper<Member>().mapArray(JSONArray: json)[0]
                    completion(Result.success(member))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func updateMember(id: Int, phoneNum: String, fines: String, password: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.updateMember(id: id, phoneNum: phoneNum, fines: fines, password: password)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func calcFines(completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.calcFines) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
