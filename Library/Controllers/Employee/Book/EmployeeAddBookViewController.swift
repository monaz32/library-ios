//
//  EmployeeAddBookViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-26.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class EmployeeAddBookViewController: UIViewController {
    static let identifier = "EmployeeAddBookViewController"
    
    @IBOutlet var isbnTextField: UITextField!
    @IBOutlet var branchNumTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var publisherTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBookAction(_ sender: Any) {
        guard let isbn = isbnTextField.text, !isbn.isEmpty, isbn.trimmingCharacters(in: .whitespaces).count > 0, let _ = Int(isbn) else {
            let alertController = UIAlertController(title: "Error", message: "Invalid ISBN", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let branchNum = branchNumTextField.text, !branchNum.isEmpty, branchNum.trimmingCharacters(in: .whitespaces).count > 0, let branchNumInt = Int(branchNum) else {
            let alertController = UIAlertController(title: "Error", message: "Invalid Branch Number", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let title = titleTextField.text, !title.isEmpty, title.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Title text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let author = authorTextField.text, !author.isEmpty, author.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Author text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let publisher = publisherTextField.text, !publisher.isEmpty, publisher.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Publisher text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let genre = genreTextField.text, !genre.isEmpty, genre.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Genre text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        BookService.sharedService.addBook(isbn: isbn, branchNum: branchNumInt, title: title, author: author, publisher: publisher, genre: genre) { (result) in
            if result.isSuccess {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Adding Book failed", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
