//
//  MemberBooksTableViewCell.swift
//  Library
//
//  Created by Paco Lee on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class MemberBooksTableViewCell: UITableViewCell {
    static let identifier = "MemberBooksTableViewCell"

    var book: Book!
    
    @IBOutlet var titleAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(book: Book) {
        self.book = book
        if let title = book.title, let author = book.author {
            titleAuthorLabel.text = "\(title) by \(author)"
        }
    }

}
