//
//  EventsViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Events", bundle: nil).instantiateViewController(withIdentifier: CreateEventViewController.identifier) as!  CreateEventViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
