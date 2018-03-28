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
                
                if let fines = member.fines {
                    self.finesLabel.text = "Total Fines: \(fines)"
                } else {
                    self.finesLabel.text = "Total Fines: 0"
                }
            }
        }
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
    }
    
    
}
