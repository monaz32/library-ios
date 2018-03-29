//
//  EmployeeMembersViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class EmployeeMembersViewController: UIViewController {
    static let identifier = "EmployeeMembersViewController"
    
    var members = [Member]()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MemberService.sharedService.getMembers { (result) in
            if result.isSuccess, let members = result.value {
                self.members = members
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty, text.trimmingCharacters(in: .whitespaces).count > 0, let id = Int(text) else {
            MemberService.sharedService.getMembers { (result) in
                if result.isSuccess, let members = result.value {
                    self.members = members
                    self.tableView.reloadData()
                }
            }
            return
        }
        
        
        MemberService.sharedService.getMember(id: id) { (result) in
            if result.isSuccess, let member = result.value {
                self.members = [member]
                self.tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "ID does not exist", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Table view delegate

extension EmployeeMembersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Account", bundle: nil).instantiateViewController(withIdentifier: MemberAccountViewController.identifier) as! MemberAccountViewController
        let member = members[indexPath.row]
        vc.config(member: member, userType: .employee)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view data source

extension EmployeeMembersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let member = members[indexPath.row]
        cell.config(member: member)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
}
