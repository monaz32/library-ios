//
//  EmployeeService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class EmployeeService {
    static let sharedService = EmployeeService()
    
    func employeeLogin(email: String, password: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.employeeLogin(email: email, password: password)) { (response) in
            switch response {
            case .success(let result):
                // Note that result is an array. This casting works because result is guaranteed
                // to contain only one object with {"eid": id}
                if let result =  result as? [[String: Any]], let id = result[0]["eid"] as? Int {
                    UserDefaults.standard.set(id, forKey: "id")
                    completion(Result.success(true))
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
