//
//  LikesViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class LikesViewController: UIViewController {
    var likedBy: [String]? = []
    var message: Message?
    var network: NetworkService?
    @IBOutlet var likedTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        network!.theToken = UserDefaults.standard.string(forKey: "token")
        likedBy = message!.likedBy
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likedTable.dataSource = self
        //likedBy = self.likedBy //again need delegate to pass on message being used.
    }
}

extension LikesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedBy!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let liked = likedBy![indexPath.item]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.nameLabel.text = liked
        return cell
    }
}
