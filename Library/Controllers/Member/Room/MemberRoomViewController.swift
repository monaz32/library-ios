//
//  MemberRoomViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class MemberRoomViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var schedules = [Schedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: MemberBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemberBooksTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScheduleService.sharedService.getSchedules { (result) in
            if result.isSuccess, let schedules = result.value {
                self.schedules = schedules
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func bookRoomAction(_ sender: Any) {
        let vc = UIStoryboard(name: "MemberRoom", bundle: nil).instantiateViewController(withIdentifier: MemberAddRoomViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table view data source

extension MemberRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberBooksTableViewCell.identifier, for: indexPath) as! MemberBooksTableViewCell
        let schedule = schedules[indexPath.row]
        cell.config(schedule: schedule)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return schedules.count
    }
}
