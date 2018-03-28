//
//  MemberBookReviewViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class MemberBookReviewViewController: UIViewController {
    static let identifier = "MemberBookReviewViewController"
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var summaryTextView: UITextView!
    @IBOutlet var ratingTextField: UITextField!
    
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func config(book: Book) {
        self.book = book
    }
    
    @IBAction func postReview(_ sender: Any) {
        guard let summary = summaryTextView.text, !summary.isEmpty, summary.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Summary text view is empty")
            return
        }
        
        guard let rating = ratingTextField.text, !rating.isEmpty, rating.trimmingCharacters(in: .whitespaces).count > 0, let ratingInt = Int(rating), ratingInt >= 0 && ratingInt <= 5 else {
            print("Rating is invalid")
            return
        }
        
        if let isbn = book.isbn {
            let id = UserDefaults.standard.integer(forKey: "id")
            ReviewService.sharedService.addReview(isbn: isbn, accountID: id, rating: ratingInt, review: summary, completion: { (result) in
                if let success = result.value, success {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
}
