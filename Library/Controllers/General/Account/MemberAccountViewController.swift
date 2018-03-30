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
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var finesLabel: UILabel!
    @IBOutlet var finesTextField: UITextField!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    var member: Member!
    var currentRentals = [Rental]()
    var pastRentals = [Rental]()
    
    var userType: UserType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        if let userType = userType, userType == .employee {
            finesTextField.isHidden = false
        } else {
            finesTextField.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }
    
    func config(member: Member, userType: UserType) {
        self.member = member
        self.userType = userType
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
        var id: Int
        if let userType = userType, userType == .employee {
            id = member.ID!
        } else {
            id = UserDefaults.standard.integer(forKey: "id")
        }
        
        MemberService.sharedService.getMember(id: id) { (result) in
            if result.isSuccess, let member = result.value {
                self.member = member
                self.nameLabel.text = "Name: \(member.name!)"
                self.emailLabel.text = "Email: \(member.email!)"
                self.phoneNumberTextField.text = member.phoneNumber
                
                if let userType = self.userType, userType == .employee {
                    self.finesTextField.text = "\(member.fines!)"
                } else {
                    self.finesLabel.text = "Total Fines: \(member.fines!)"
                }
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
        guard let phone = phoneNumberTextField.text, !phone.isEmpty, phone.trimmingCharacters(in: .whitespaces).count > 0, let _ = Int(phone) else {
            let alertController = UIAlertController(title: "Error", message: "Invalid Phone text field", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        var id: Int
        if let userType = userType, userType == .employee {
            id = member.ID!
        } else {
            id = UserDefaults.standard.integer(forKey: "id")
        }
        
        var fines: Double
        if let userType = userType, userType == .employee {
            guard let finesText = finesTextField.text, !finesText.isEmpty, finesText.trimmingCharacters(in: .whitespaces).count > 0, let finesDouble = Double(finesText), finesDouble >= 0 else {
                let alertController = UIAlertController(title: "Error", message: "Invalid Fines field", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            fines = finesDouble
        } else {
            fines = member.fines!
        }
        
        print(fines)
        
        MemberService.sharedService.updateMember(id: id, phoneNum: phone, fines: fines, password: "") { (result) in
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
