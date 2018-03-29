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
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
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
                self.phoneTextField.text = employee.phoneNumber
                self.addressTextField.text = employee.address
            }
        }
        
    }
    
    @IBAction func updateAction(_ sender: Any) {
        guard let phone = phoneTextField.text, !phone.isEmpty, phone.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Phone text field is empty")
            return
        }

        guard let address = addressTextField.text, !address.isEmpty, address.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Address text field is empty")
            return
        }
        
        let id = UserDefaults.standard.integer(forKey: "id")
        
        EmployeeService.sharedService.updateEmployee(id: id, address: address, phoneNumber: phone) { (result) in
            var alertController: UIAlertController
            
            if result.isSuccess {
                alertController = UIAlertController(title: "Update succesful", message: "", preferredStyle: .alert)
            } else {
                alertController = UIAlertController(title: "Update not succesful", message: "", preferredStyle: .alert)
            }
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
