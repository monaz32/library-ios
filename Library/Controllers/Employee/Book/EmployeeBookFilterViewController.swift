//
//  EmployeeBookFilterViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-26.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class EmployeeBookFilterViewController: UIViewController {
    static let identifier = "EmployeeBookFilterViewController"

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var publisherTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    
    var delegate: EmployeeBooksViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(delegate: EmployeeBooksViewControllerDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func addFiltersAction(_ sender: Any) {
        var title: String
        var author: String
        var publisher: String
        var genre: String
        
        if titleTextField.text == nil {
            title = ""
        } else {
            title = titleTextField.text!
        }
        
        if authorTextField.text == nil {
            author = ""
        } else {
            author = authorTextField.text!
        }
        
        if publisherTextField.text == nil {
            publisher = ""
        } else {
            publisher = publisherTextField.text!
        }
        
        if genreTextField.text == nil {
            genre = ""
        } else {
            genre = genreTextField.text!
        }
        
        let bookFilter = BookFilter(title: title, author: author, publisher: publisher, genre: genre)
        
        delegate.changeFilter(bookFilter: bookFilter)
        navigationController?.popViewController(animated: true)
    }
}
