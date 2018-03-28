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
    
    // get details on all employees
    func getEmployees(completion: @escaping (Result<[Employee]>) -> Void) {
        APIClient.sharedClient.request(Router.getEmployees) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let employees = Mapper<Employee>().mapArray(JSONArray: json)
                    completion(Result.success(employees))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // add an employee
    func addEmployee(email: String, sin: String, name: String, address: String, phoneNumber: String, branchNumber: Int,
                     adminStatus: Bool, password: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addEmployee(email: email, sin: sin, name: name, address: address, phoneNumber: phoneNumber, branchNumber: branchNumber, adminStatus: adminStatus, password: password)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // get an employee based on employee id
    func getEmployee(id: String, completion: @escaping (Result<Employee>) -> Void) {
        APIClient.sharedClient.request(Router.getEmployee(id: id)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let employees = Mapper<Employee>().mapArray(JSONArray: json)
                    // There is only one employee with the corresponding id, so we return
                    // the first element of the array.
                    completion(Result.success(employees[0]))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    // employee login
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
