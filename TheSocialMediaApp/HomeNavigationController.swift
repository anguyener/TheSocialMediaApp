//
//  HomeNavigationController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 12/14/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController {
    
    var network: NetworkService?
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.network = self.network
        present(homeViewController, animated: true, completion: nil)
    }
}

