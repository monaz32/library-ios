//
//  ReviewTableViewCell.swift
//  Library
//
//  Created by Paco Lee on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    static let identifier = "ReviewTableViewCell"

    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    var review: ReviewDisplayed!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(review: ReviewDisplayed) {
        self.review = review
        
        if let rating = review.rating, let summary = review.review {
            ratingLabel.text = "Rating: \(rating)"
            summaryLabel.text = "Summary: \(summary)"
        }
    }
}
