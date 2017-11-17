//
//  LikesViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class LikesViewController: UITableViewController {
    var likedBy: [String] = []
    
    let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    
    @IBOutlet var likedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likedTable.dataSource = self
        likedBy = message.likedBy //again need delegate to pass on message being used.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedBy.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let liked = likedBy[indexPath.item]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.nameLabel.text = liked
        return cell
    }
}

