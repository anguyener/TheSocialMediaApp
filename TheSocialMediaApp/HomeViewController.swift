//
//  HomeViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var messages: [Message] = []
    
    let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self //as! UITableViewDataSource // -_-
        messages = network.getMessages()
        greetingLabel.text = "Welcome! Write something to get started."
        messageTextView.delegate = self as! UITextViewDelegate
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        network.postMessage(message: Message(user: , text: messageTextView.text, date: Date(), imgURL: nil, id: nil, replyTo: nil, likedBy: nil))
        messageTextView.delete(<#Any?#>)
    }
}
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        cell.configure(messages[indexPath.item], LVC: LikesViewController)
        return cell
    }
    
    
}
