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
    var reviews =  [ReviewDisplayed]()
    var libraryBooks = [LibraryBook]()

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let isbn = book.isbn {
            ReviewService.sharedService.getReviews(isbn: isbn, completion: { (result) in
                if result.isSuccess, let reviews = result.value {
                    self.reviews = reviews
                    self.reviewTableView.reloadData()
                } else {
                    let alertController = UIAlertController(title: "Error 422", message: "Unprocessable Entity", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
            LibraryBookService.sharedService.getLibraryBooks(isbn: isbn, completion: { (result) in
                if result.isSuccess, let libraryBooks = result.value {
                    self.libraryBooks = libraryBooks
                    self.libraryBookTableView.reloadData()
                } else {
                    let alertController = UIAlertController(title: "Error 422", message: "Unprocessable Entity3", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    func config(book: Book) {
        self.book = book
    }
    
    private func setup() {
        setupTableView()
        if let title = book.title, let genre = book.genre, let isbn = book.isbn {
            titleLabel.text = "Title: \(title)"
            genreLabel.text = "Genre: \(genre)"
            isbnLabel.text = "ISBN: \(isbn)"
        
            RatingService.sharedService.getAVRRating(isbn: isbn, completion: { (result) in
                if result.isSuccess, let averageRating = result.value {
                    if (averageRating < 0) {
                        // Book does not have an average rating.
                        self.averageRatingLabel.text = "Average Rating: No Rating"
                    } else {
                        self.averageRatingLabel.text = "Average Rating: \(averageRating)"
                    }
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
    
    private func setupTableView() {
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: ReviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.identifier)
        reviewTableView.rowHeight = UITableViewAutomaticDimension
        reviewTableView.estimatedRowHeight = 44
        reviewTableView.tableFooterView = UIView()
        
        
        libraryBookTableView.delegate = self
        libraryBookTableView.dataSource = self
        libraryBookTableView.register(UINib(nibName: LibraryBookTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LibraryBookTableViewCell.identifier)
        libraryBookTableView.rowHeight = UITableViewAutomaticDimension
        libraryBookTableView.estimatedRowHeight = 44
        libraryBookTableView.tableFooterView = UIView()
    }
    
    @IBAction func addReview(_ sender: Any) {
        let vc = UIStoryboard(name: "MemberBooks", bundle: nil).instantiateViewController(withIdentifier: MemberBookReviewViewController.identifier) as! MemberBookReviewViewController
        vc.config(book: book)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view delegate

extension MemberBookDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let libraryBook = libraryBooks[indexPath.row]
        if libraryBook.status == true,  let bookID = libraryBook.ID {
            let memberID = UserDefaults.standard.integer(forKey: "id")
            RentalService.sharedService.addRental(memberID: memberID, bookID: bookID, fromTime: "09:34", fromDate: "04/04/18", completion: { (result) in
                if result.isSuccess {
                    LibraryBookService.sharedService.getLibraryBooks(isbn: self.book.isbn!, completion: { (result) in
                        if result.isSuccess, let libraryBooks = result.value {
                            self.libraryBooks = libraryBooks
                            self.libraryBookTableView.reloadData()
                        } else {
                            let alertController = UIAlertController(title: "Error 422", message: "Unprocessable Entity", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                            }
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
                } else {
                    let alertController = UIAlertController(title: "Error 422", message: "Unprocessable Entity", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        } else {
            let alertController = UIAlertController(title: "Booked Already Checked Out", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - Table view data source

extension MemberBookDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == reviewTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as! ReviewTableViewCell
            let review = reviews[indexPath.row]
            cell.config(review: review)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LibraryBookTableViewCell.identifier, for: indexPath) as! LibraryBookTableViewCell
            let libraryBook = libraryBooks[indexPath.row]
            cell.config(libraryBook: libraryBook)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == reviewTableView {
            return reviews.count
        } else {
            return libraryBooks.count
        }
    }
}
