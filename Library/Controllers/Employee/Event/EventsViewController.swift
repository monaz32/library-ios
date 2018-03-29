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
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        eventsTableView.rowHeight = UITableViewAutomaticDimension
        eventsTableView.estimatedRowHeight = 44
        eventsTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EventService.sharedService.getEvents { (result) in
            if result.isSuccess, let events = result.value {
                self.events = events
                self.eventsTableView.reloadData()
            }
        }
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Events", bundle: nil).instantiateViewController(withIdentifier: CreateEventViewController.identifier) as!  CreateEventViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view data source

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let event = events[indexPath.row]
        cell.config(event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
}
