//
//  WelcomeViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-09.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit
import Alamofire

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BookService.sharedService.getBook(isbn: "1000") { (result) in
            print(result.value?.author)
        }
    }
    
    @IBAction func employeeAction(_ sender: Any) {
        login(userType: .employee)
    }
    
    @IBAction func memberAction(_ sender: Any) {
        login(userType: .member)
    }
    
    private func login(userType: UserType) {
        let vc = UIStoryboard.init(name: "Welcome", bundle: nil).instantiateViewController(withIdentifier: LoginViewController.identifier) as! LoginViewController
        vc.setup(with: userType)
        navigationController?.pushViewController(vc, animated: true)
    }
}
