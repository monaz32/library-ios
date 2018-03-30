//
//  BookCountViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-29.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class BookCountViewController: UIViewController {
    static let identifier = "BookCountViewController"

    @IBOutlet var tableView: UITableView!
    var genreCounts = [GenreCount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupTableView()
        BookService.sharedService.getBookGenreCount { (result) in
            if result.isSuccess, let genreCounts = result.value {
                self.genreCounts = genreCounts
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

extension BookCountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let genreCount = genreCounts[indexPath.row]
        cell.config(genreCount: genreCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreCounts.count
    }
}

