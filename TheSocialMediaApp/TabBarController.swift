//
//  TabBarController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 12/14/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var network: NetworkService?
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! HomeNavigationController
        homeNavigationController.network = self.network
        present(homeNavigationController, animated: true, completion: nil)
    }
}
