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
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var sinLabel: UILabel!
    @IBOutlet var sinTextField: UITextField!
    @IBOutlet var adminLabel: UILabel!
    @IBOutlet var adminYesButton: UIButton!
    @IBOutlet var adminNoButton: UIButton!
    
    var isAdmin = false
    var userType: UserType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setup(with userType: UserType) {
        self.userType = userType
        if userType == .member {
            navigationController?.title = "Member Registration"
        } else if userType == .employee {
            navigationController?.title = "Employee Registration"
        }
    }
    
    func setupUI() {
        if userType == .member {
            sinLabel.isHidden = true
            sinTextField.isHidden = true
            adminLabel.isHidden = true
            adminYesButton.isHidden = true
            adminNoButton.isHidden = true
        }
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
        
        var vc: UIViewController!
        
        if userType == .member {
            MemberService.sharedService.addMember(phoneNum: phone, email: email, name: name, password: password, completion: { (result) in
                if result.value == true {
                    vc = UIStoryboard.init(name: "Member", bundle: nil).instantiateInitialViewController()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = vc
                }
            })
        } else {
            guard let sin = sinTextField.text, !sin.isEmpty, sin.trimmingCharacters(in: .whitespaces).count > 0 else {
                print("SIN text field is empty")
                return
            }
            
            vc = UIStoryboard.init(name: "Employee", bundle: nil).instantiateInitialViewController()
        }
    }
}
