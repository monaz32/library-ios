//
//  RegisterViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    static let identifier = "RegisterViewController"

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var sinLabel: UILabel!
    @IBOutlet var sinTextField: UITextField!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var branchNumberLabel: UILabel!
    @IBOutlet var branchNumberTextField: UITextField!
    
    @IBOutlet var adminLabel: UILabel!
    @IBOutlet var adminYesButton: UIButton!
    @IBOutlet var adminNoButton: UIButton!
    
    var isAdmin = false
    var userType: UserType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setup(with userType: UserType) {
        self.userType = userType
    }
    
    func setupUI() {
        if let userType = userType, userType == .member {
            sinLabel.isHidden = true
            sinTextField.isHidden = true
            adminLabel.isHidden = true
            adminYesButton.isHidden = true
            adminNoButton.isHidden = true
            addressLabel.isHidden = true
            addressTextField.isHidden = true
            branchNumberLabel.isHidden = true
            branchNumberTextField.isHidden = true
        }
    }
    
    @IBAction func yesButton(_ sender: Any) {
        isAdmin = true
    }
    
    @IBAction func notButton(_ sender: Any) {
        isAdmin = false
    }
    
    @IBAction func registerAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty, name.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Name text field is empty")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty, email.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Email text field is empty")
            return
        }
        
        guard let phone = phoneTextField.text, !phone.isEmpty, phone.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Phone text field is empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty, password.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Password text field is empty")
            return
        }
        
        if let userType = userType, userType == .member {
            MemberService.sharedService.addMember(phoneNum: phone, email: email, name: name, password: password, completion: { (result) in
                if result.value == true {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alertController = UIAlertController(title: "Registration Failed", message: "Check Fields", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        } else {
            guard let sin = sinTextField.text, !sin.isEmpty, sin.trimmingCharacters(in: .whitespaces).count > 0 else {
                print("SIN text field is empty")
                return
            }
            
            guard let address = addressTextField.text, !address.isEmpty, address.trimmingCharacters(in: .whitespaces).count > 0 else {
                print("Address text field is empty")
                return
            }
            
            guard let branchNum = branchNumberTextField.text, !branchNum.isEmpty, branchNum.trimmingCharacters(in: .whitespaces).count > 0, let branchNumInt = Int(branchNum), branchNumInt >= 0, branchNumInt <= 5  else {
                print("Branch num text field is invalid")
                return
            }
            
            EmployeeService.sharedService.addEmployee(email: email, sin: sin, name: name, address: address, phoneNumber: phone, branchNumber: branchNumInt, adminStatus: isAdmin, password: password, completion: { (result) in
                if result.isSuccess {
                    let alertController = UIAlertController(title: "Registration Succesful", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Registration Failed", message: "Check Fields", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
}
