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
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
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
                self.nameLabel.text = "Name: \(employee.name!)"
                self.emailLabel.text = "Email: \(employee.email!)"
                self.phoneTextField.text = employee.phoneNumber
                self.addressTextField.text = employee.address
                self.adminLabel.text = employee.adminStatus! ? "Admin: Yes" : "Admin: No"
            }
        }
    }
    
    @IBAction func updateAction(_ sender: Any) {
        guard let phone = phoneTextField.text, !phone.isEmpty, phone.trimmingCharacters(in: .whitespaces).count > 0, let _ = Int(phone) else {
            let alertController = UIAlertController(title: "Error", message: "Invalid Phone text field", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }

        guard let address = addressTextField.text, !address.isEmpty, address.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Address text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
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
