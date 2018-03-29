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
    var currentRentals = [Rental]()
    var pastRentals = [Rental]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }
    
    private func setupTableView() {
        pastHistoryTableView.dataSource = self
        pastHistoryTableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        pastHistoryTableView.rowHeight = UITableViewAutomaticDimension
        pastHistoryTableView.estimatedRowHeight = 44
        pastHistoryTableView.tableFooterView = UIView()
        
        bookTableView.dataSource = self
        bookTableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        bookTableView.rowHeight = UITableViewAutomaticDimension
        bookTableView.estimatedRowHeight = 44
        bookTableView.tableFooterView = UIView()
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
        
        RentalService.sharedService.getCurrentRentalsOfMember(id: id) { (result) in
            if result.isSuccess, let currentRentals = result.value {
                self.currentRentals = currentRentals
                self.bookTableView.reloadData()
            }
        }
        
        RentalService.sharedService.getAllRentalsOfMember(id: id) { (result) in
            if result.isSuccess, let pastRentals = result.value {
                self.pastRentals = pastRentals
                self.pastHistoryTableView.reloadData()
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
        
        guard let phone = phoneNumberTextField.text, !phone.isEmpty, phone.trimmingCharacters(in: .whitespaces).count > 0, let _ = Int(phone) else {
            let alertController = UIAlertController(title: "Error", message: "Invalid Phone text field", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
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

// MARK: - Table view data source

extension MemberAccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == pastHistoryTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
            let pastRental = pastRentals[indexPath.row]
            cell.config(rental: pastRental)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
            let currentRental = currentRentals[indexPath.row]
            cell.config(rental: currentRental)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pastHistoryTableView {
            return pastRentals.count
        } else {
            return currentRentals.count
        }
    }
}
