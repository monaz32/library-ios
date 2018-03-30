//
//  InfoViewController.swift
//  Library
//
//  Created by Paco Lee on 2018-03-29.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func branchesAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: BranchesViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func highestRatedAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: HighestRatedViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func lowestRatingAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: LowestRatedViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func booksCountAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: BookCountViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}
