//
//  HighestRatedViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-29.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class HighestRatedViewController: UIViewController {
    static let identifier = "HighestRatedViewController"

    @IBOutlet var tableView: UITableView!
    var ratings = [Rating]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupTableView()
    
        RatingService.sharedService.getMAXRating { (result) in
            if result.isSuccess, let ratings = result.value {
                self.ratings = ratings
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

extension HighestRatedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let rating = ratings[indexPath.row]
        cell.config(rating: rating)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
}
