//
//  MemberAddRoomViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class MemberAddRoomViewController: UIViewController {
    static let identifier = "MemberAddRoomViewController"

    @IBOutlet var roomNameTextField: UITextField!
    @IBOutlet var fromDateTextField: UITextField!
    @IBOutlet var toDateTextField: UITextField!
    @IBOutlet var fromTimeTextField: UITextField!
    @IBOutlet var toTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bookRoom(_ sender: Any) {
        guard let roomName = roomNameTextField.text, !roomName.isEmpty, roomName.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("Room name text field is empty")
            return
        }
        
        guard let fromDate = fromDateTextField.text, !fromDate.isEmpty, fromDate.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("From date text field is empty")
            return
        }
        
        guard let fromTime = fromTimeTextField.text, !fromTime.isEmpty, fromTime.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("From time text field is empty")
            return
        }
        
        guard let toDate = toDateTextField.text, !toDate.isEmpty, toDate.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("To Date text field is empty")
            return
        }
        
        guard let toTime = toTimeTextField.text, !toTime.isEmpty, toTime.trimmingCharacters(in: .whitespaces).count > 0 else {
            print("To Time text field is empty")
            return
        }
        
        let id = UserDefaults.standard.integer(forKey: "id")
        ScheduleService.sharedService.addSchedule(accountID: id, roomName: roomName, fromTime: fromTime, fromDate: fromDate, toTime: toTime, toDate: toDate) { (result) in
            if result.isSuccess {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Booking Room failed", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
