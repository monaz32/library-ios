//
//  EmployeeBooksViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-26.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

protocol EmployeeBooksViewControllerDelegate {
    func changeFilter(bookFilter: BookFilter)
}

class EmployeeBooksViewController: UIViewController {

    @IBOutlet var bookTableView: UITableView!
    
    var bookFilter = BookFilter(title: "", author: "", publisher: "", genre: "")
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        bookTableView.rowHeight = UITableViewAutomaticDimension
        bookTableView.estimatedRowHeight = 44
        bookTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BookService.sharedService.getBooks(title: bookFilter.title, author: bookFilter.author, publisher: bookFilter.publisher, genre: bookFilter.genre) { (result) in
            if result.isSuccess, let books = result.value{
                self.books = books
                self.bookTableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "Error 422", message: "Unprocessable Entity", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addBookAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "EmployeeBooks", bundle: nil).instantiateViewController(withIdentifier: EmployeeAddBookViewController.identifier) as! EmployeeAddBookViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addFiltersAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "EmployeeBooks", bundle: nil).instantiateViewController(withIdentifier: EmployeeBookFilterViewController.identifier) as! EmployeeBookFilterViewController
        vc.setup(delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view delegate

extension EmployeeBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "MemberBooks", bundle: nil).instantiateViewController(withIdentifier: MemberBookDetailsViewController.identifier) as! MemberBookDetailsViewController
        let book = books[indexPath.row]
        vc.config(book: book, userType: .employee)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view data source

extension EmployeeBooksViewController: UITableViewDataSource {
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

// MARK: - EmployeeBooksViewControllerDelegate

extension EmployeeBooksViewController: EmployeeBooksViewControllerDelegate {
    func changeFilter(bookFilter: BookFilter) {
        self.bookFilter = bookFilter
    }
}
