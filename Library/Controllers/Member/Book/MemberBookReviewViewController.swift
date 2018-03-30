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
            let alertController = UIAlertController(title: "Error", message: "Summary text view is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let rating = ratingTextField.text, !rating.isEmpty, rating.trimmingCharacters(in: .whitespaces).count > 0, let ratingInt = Int(rating), ratingInt >= 0 && ratingInt <= 5 else {
            let alertController = UIAlertController(title: "Error", message: "Rating is invalid", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if let isbn = book.isbn {
            let id = UserDefaults.standard.integer(forKey: "id")
            ReviewService.sharedService.addReview(isbn: isbn, accountID: id, rating: ratingInt, review: summary, completion: { (result) in
                if result.isSuccess, let success = result.value, success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error 422", message: "Unprocessable Entity", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
}
