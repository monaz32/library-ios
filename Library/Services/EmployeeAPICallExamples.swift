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
            print(employees[0].email)
        }
    }
    
    // add an employee
    func addEmployee() {
        EmployeeService.sharedService.addEmployee(email: "jane.smith@library.com", sin: "201803272", name: "SMITH, JANE", address: "83742 Main St", phoneNumber: "6045555432", branchNumber: 2, adminStatus: false, password: "cs304") { (result) in
            switch result {
            case .success:
                print("addEmployee success")
            case .failure:
                print("addEmployee failure")
            }
        }
    }
    
    // get an employee based on eid
    func getEmployee() {
        EmployeeService.sharedService.getEmployee(id: "590912") { (result) in
            switch result {
            case .success:
                print("getEmployee success")
                
                let employee = result.value!
                print(employee.address)
            case .failure:
                print("getEmployee failure")
            }
        }
    }
    
    // update an employee
    func updateEmployee() {
        EmployeeService.sharedService.updateEmployee(id: "591925", email: "john.smith@library.com", address: "83742 Main St", phoneNumber: "6045555432", password: "cs304") { (result) in
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
                print(employees[0].name)
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
