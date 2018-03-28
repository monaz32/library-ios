//
//  MemberBooksViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

protocol MemberBooksViewControllerDelegate {
    func changeFilter(bookFilter: BookFilter)
}

class MemberBooksViewController: UIViewController {
    static let identifier = "MemberBooksViewController"
    
    @IBOutlet var tableView: UITableView!
    
    var bookFilter = BookFilter(title: "", author: "", publisher: "", genre: "")
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BookService.sharedService.getBooks(title: bookFilter.title, author: bookFilter.author, publisher: bookFilter.publisher, genre: bookFilter.genre) { (result) in
            if let books = result.value {
                self.books = books
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "MemberBooks", bundle: nil).instantiateViewController(withIdentifier: MemberBookFilterViewController.identifier) as! MemberBookFilterViewController
        vc.setup(delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view delegate

extension MemberBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "MemberBooks", bundle: nil).instantiateViewController(withIdentifier: MemberBookDetailsViewController.identifier) as! MemberBookDetailsViewController
        let book = books[indexPath.row]
        vc.setup(book: book)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view data source

extension MemberBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let book = books[indexPath.row]
        cell.config(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
}

// MARK: - MemberBooksViewControllerDelegate

extension MemberBooksViewController: MemberBooksViewControllerDelegate {
    func changeFilter(bookFilter: BookFilter) {
        self.bookFilter = bookFilter
    }
}
