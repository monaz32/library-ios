//
//  CreateEventViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var branchNumTextField: UITextField!
    @IBOutlet var fromTimeTextField: UITextField!
    @IBOutlet var toTimeTextField: UITextField!
    @IBOutlet var fromDateTextField: UITextField!
    @IBOutlet var toDateTextField: UITextField!
    
    
    static let identifier = "CreateEventViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty, name.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Name text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let branchNum = branchNumTextField.text, !branchNum.isEmpty, branchNum.trimmingCharacters(in: .whitespaces).count > 0, let branchNumInt = Int(branchNum) else {
            let alertController = UIAlertController(title: "Error", message: "Invalid branch number", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let fromDate = fromDateTextField.text, !fromDate.isEmpty, fromDate.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "From date text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let fromTime = fromTimeTextField.text, !fromTime.isEmpty, fromTime.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "From time text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let toDate = toDateTextField.text, !toDate.isEmpty, toDate.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "To Date text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let toTime = toTimeTextField.text, !toTime.isEmpty, toTime.trimmingCharacters(in: .whitespaces).count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "To Time text field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        EventService.sharedService.addEvent(name: name, branchNum: branchNumInt, fromTime: fromTime, toTime: toTime, fromDate: fromDate, toDate: toDate) { (result) in
            if result.isSuccess {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Creating Event Failed", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
