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
        var vc: UIViewController!
        
        if userType == .member {
            vc = UIStoryboard.init(name: "Member", bundle: nil).instantiateInitialViewController()
        } else {
            vc = UIStoryboard.init(name: "Employee", bundle: nil).instantiateInitialViewController()
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
}
