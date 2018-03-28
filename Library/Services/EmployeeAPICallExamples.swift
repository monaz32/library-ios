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
