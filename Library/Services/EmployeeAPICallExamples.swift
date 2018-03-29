//
//  EmployeeAPICallExamples.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class EmployeeAPICallExamples {
    // get all employees
    func getEmployees() {
        EmployeeService.sharedService.getEmployees { (result) in
            let employees = result.value!
            print(employees[0].email!)
        }
    }
    
    // add an employee
    func addEmployee() {
        EmployeeService.sharedService.addEmployee(email: "jane.bop@library.com", sin: "201803293", name: "BOP, JANE", address: "83742 Second St", phoneNumber: "6045555", branchNumber: 4, adminStatus: false, password: "cs304") { (result) in
            switch result {
            case .success:
                print("addEmployee success")
                print(result.value!)
            case .failure:
                print("addEmployee failure")
            }
        }
    }
    
    
    // update an employee
    func updateEmployee() {
        EmployeeService.sharedService.updateEmployee(id: 591925, address: "83742 Main St", phoneNumber: "6045555432") { (result) in
            switch result {
            case .success:
                print("updateEmployee success")
            case .failure:
                print("updateEmployee failure")
            }
        }
    }
    
    // get information on employees with specified name
    func getEmployeeFromName() {
        EmployeeService.sharedService.getEmployeeFromName(name: "lee") { (result) in
            switch result {
            case .success:
                print("getEmployeeFromName success")
                
                let employees = result.value!
                print(employees[0].name!)
            case .failure:
                print("getEmployeeFromName failure")
            }
        }
    }
    
    // employee login
    func employeeLogin() {
        EmployeeService.sharedService.employeeLogin(email: "h.ashcroft@library.com", password: "cs304") { (result) in
            switch result {
            case .success:
                print("employeeLogin success")
            case .failure:
                print("employeeLogin failure")
            }
        }
    }
}
