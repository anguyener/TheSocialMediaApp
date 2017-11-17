//
//  SingleViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {
    
    let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    @IBOutlet weak var singleMessage: UITableView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var commentBox: UITextView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleMessage.dataSource = self
        headerLabel.text = "Comment"
        commentBox.delegate = self as! UITextViewDelegate
        commentsTableView.dataSource = self
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        network.postMessage(message: Message(user: , text: commentBox.text, date: Date(), imgURL: nil, id: nil, replyTo: nil, likedBy: nil))
        commentBox.delete(<#T##sender: Any?##Any?#>)
    }
}
//this is for first table view, can you have two table views in one view Controller? extend again?
extension SingleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        cell.configure( ///messages[indexPath.item]) how get single message? delegate passes it on?
        return cell
    }
}
