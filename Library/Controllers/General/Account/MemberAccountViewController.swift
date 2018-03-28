//
//  MemberAccountViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class MemberAccountViewController: UIViewController {
    static let identifier = "MemberAccountViewController"
    
    @IBOutlet var bookTableView: UITableView!
    @IBOutlet var pastHistoryTableView: UITableView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var finesLabel: UILabel!
    
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }
    
    func setup() {
        let id = UserDefaults.standard.integer(forKey: "id")
        MemberService.sharedService.getMember(id: id) { (result) in
            if result.isSuccess, let member = result.value {
                self.member = member
                self.nameTextField.text = member.name
                self.emailTextField.text = member.email
                self.phoneNumberTextField.text = member.phoneNumber
                
                if member.fines == nil {
                    member.fines = 0
                }
                
                self.finesLabel.text = "Total Fines: \(member.fines!)"
            }
        }
    }
    
    @IBAction func updateAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty, name.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Name text field is empty")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty, email.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Email text field is empty")
            return
        }
        
        guard let phone = phoneNumberTextField.text, !phone.isEmpty, phone.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Phone text field is empty")
            return
        }
        
        let id = UserDefaults.standard.integer(forKey: "id")
        
        MemberService.sharedService.updateMember(id: id, phoneNum: phone, fines: member.fines!, password: "") { (result) in
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
