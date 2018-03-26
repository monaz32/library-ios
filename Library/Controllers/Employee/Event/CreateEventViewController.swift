//
//  CreateEventViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    static let identifier = "CreateEventViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
