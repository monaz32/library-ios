//
//  LibraryBookTableViewCell.swift
//  Library
//
//  Created by Paco Lee on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class LibraryBookTableViewCell: UITableViewCell {
    static let identifier = "LibraryBookTableViewCell"
    
    @IBOutlet var bookIDLabel: UILabel!
    @IBOutlet var branchNumLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    var libraryBook: LibraryBook!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(libraryBook: LibraryBook) {
        self.libraryBook = libraryBook
        if let id = libraryBook.ID, let branchNum = libraryBook.branchNum, let status = libraryBook.status {
            bookIDLabel.text = "\(id)"
            branchNumLabel.text = "\(branchNum)"
            
            if status == true {
                statusLabel.text = "Status: Available"
            } else {
                statusLabel.text = "Status: Check Out"
            }
        }
    }
}
