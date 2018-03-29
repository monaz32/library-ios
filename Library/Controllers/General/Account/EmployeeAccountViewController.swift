//
//  EmployeeAccountViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class EmployeeAccountViewController: UIViewController {
    static let identifier = "EmployeeAccountViewController"
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var sinTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var branchNumTextField: UITextField!
    @IBOutlet var adminLabel: UILabel!
    
    var employee: Employee!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let id = UserDefaults.standard.integer(forKey: "id")
        EmployeeService.sharedService.getEmployee(id: Int(id)) { (result) in
            if result.isSuccess, let employee = result.value {
                self.employee = employee
                self.nameTextField.text = employee.name
                self.emailTextField.text = employee.email
                self.phoneTextField.text = employee.phoneNumber
                self.sinTextField.text = employee.SIN
                self.addressTextField.text = employee.address
                self.branchNumTextField.text = "\(employee.branchNum!)"
                self.adminLabel.text = employee.adminStatus! ? "Admin: Yes" : "Admin No"
            }
        }
        
    }
}
