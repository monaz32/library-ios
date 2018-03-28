//
//  MemberBookDetailsViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class MemberBookDetailsViewController: UIViewController {
    static let identifier = "MemberBookDetailsViewController"
    
    var book: Book!

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    @IBOutlet var isbnLabel: UILabel!
    
    @IBOutlet var averageRatingLabel: UILabel!
    @IBOutlet var reviewTableView: UITableView!
    @IBOutlet var libraryBookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func config(book: Book) {
        self.book = book
    }
    
    private func setup() {
        if let title = book.title, let genre = book.genre, let isbn = book.isbn {
            titleLabel.text = "Title: \(title)"
            genreLabel.text = "Genre: \(genre)"
            isbnLabel.text = "ISBN: \(isbn)"
        }
    
        
    }
    
    @IBAction func addReview(_ sender: Any) {
    }
    
    
    
}
