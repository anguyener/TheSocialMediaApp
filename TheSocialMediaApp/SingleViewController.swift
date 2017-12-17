//
//  SingleViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {
    
    var message: Message?
    var comments: [Message]?
    var network: NetworkService?
    
    @IBOutlet weak var singleMessage: UITableView!
    
    @IBOutlet weak var commentBox: UITextField!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        network?.theToken = UserDefaults.standard.string(forKey: "token")
        self.comments = self.network!.getMessages() { (result) in
            DispatchQueue.main.async {
                self.comments = result.filter({ $0.replyTo == self.message?.id}).sorted(by: { $0.date.compare($1.date) == .orderedDescending})
                self.commentsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleMessage.dataSource = self
        commentsTableView.dataSource = self
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        self.network!.postMessage(message: Message(user: self.network!.getName(), text: self.commentBox.text!, date: Date(), imgURL: nil, id: nil, replyTo: message?.id, likedBy: nil)) {
             DispatchQueue.main.async {
            self.viewWillAppear(true) // o-O
             }
        }
        self.commentBox.text = ""
        DispatchQueue.main.async {
            self.commentsTableView.reloadData() //?
        }
    }
}

extension SingleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        
        if tableView == self.singleMessage {
            count = 1
        }
        else if tableView == self.commentsTableView {
            count = comments?.count ?? 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MessageCell?
        if tableView == self.singleMessage {
            cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
            cell!.configure(message!, delegate: self)
        }
        else if tableView == self.commentsTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
            cell!.configure(comments![indexPath.item], delegate: self)
        }
        return cell!
    }
}

extension SingleViewController: MessageCellDelegate {
    func performLike(id: String?) {
        DispatchQueue.main.async {
            self.network?.postLike(messageID: id!) {}
            self.singleMessage.reloadData()
        }
    }
    
    func showDetail(message: Message?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LVC = storyboard.instantiateViewController(withIdentifier: "LikesViewController") as! LikesViewController
        LVC.network = self.network
        LVC.message = message
        navigationController?.pushViewController(LVC, animated: true)
    }
}
