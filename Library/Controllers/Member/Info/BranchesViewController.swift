//
//  BranchesViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-29.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class BranchesViewController: UIViewController {
    static let identifier = "BranchesViewController"
    
    @IBOutlet var tableView: UITableView!
    var branches = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupTableView()
        BranchService.sharedService.getBranchWithAllBooks { (result) in
            if result.isSuccess, let branches = result.value {
                self.branches = branches
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Table view data source

extension BranchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let branch = branches[indexPath.row]
        cell.config(branch: branch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branches.count
    }
}


