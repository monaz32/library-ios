//
//  EmployeeBooksViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-26.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class EmployeeBooksViewController: UIViewController {

    @IBOutlet var bookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addBookAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "EmployeeBooks", bundle: nil).instantiateViewController(withIdentifier: EmployeeAddBookViewController.identifier) as! EmployeeAddBookViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addFiltersAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "EmployeeBooks", bundle: nil).instantiateViewController(withIdentifier: EmployeeBookFilterViewController.identifier) as! EmployeeBookFilterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
