//
//  LoginViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit
enum UserType {
    case member
    case employee
}

class LoginViewController: UIViewController {
    static let identifier = "LoginViewController"
    var userType: UserType!

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(with userType: UserType) {
        self.userType = userType
        
        if userType == .member {
            navigationController?.title = "Member Login"
        } else {
            navigationController?.title = "Employee Login"
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Welcome", bundle: nil).instantiateViewController(withIdentifier: RegisterViewController.identifier) as! RegisterViewController
        vc.setup(with: userType)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailTextfield.text, !email.isEmpty, email.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Email text field is empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty, password.trimmingCharacters(in: .whitespaces).count > 0   else {
            print("Password text field is empty")
            return
        }
        if userType == .member {
            MemberService.sharedService.memberLogin(email: email, password: password) { (result) in
                if result.value == true {
                    let vc = UIStoryboard.init(name: "Member", bundle: nil).instantiateInitialViewController()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = vc
                } else {
                    let alertController = UIAlertController(title: "Login Failed", message: "Check email or password", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            EmployeeService.sharedService.employeeLogin(email: email, password: password, completion: { (result) in
                if result.value == true {
                    let vc = UIStoryboard.init(name: "Employee", bundle: nil).instantiateInitialViewController()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = vc
                } else {
                    let alertController = UIAlertController(title: "Login Failed", message: "Check email or password", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
}
