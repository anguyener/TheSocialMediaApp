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
    //  let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    @IBOutlet weak var singleMessage: UITableView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var commentBox: UITextField!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        network?.theToken = UserDefaults.standard.string(forKey: "token")
        comments = network!.getMessages() { (result) in
            self.comments = result.filter({ $0.replyTo == self.message?.replyTo}).sorted(by: { $0.date.compare($1.date) == .orderedDescending})
            self.commentsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleMessage.dataSource = self
        headerLabel.text = "Comment"
        commentBox.delegate = self as! UITextFieldDelegate
        commentsTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LikesViewController else { return }
        // guard let source = sender as? RecipieCell else { return }
        destination.likedBy = (message?.likedBy)!
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        network!.postMessage(message: Message(user: network!.getName(), text: commentBox.text!, date: Date(), imgURL: nil, id: nil, replyTo: nil, likedBy: nil)) {
            DispatchQueue.main.async {
                self.viewWillAppear(true)
            }
        }
        commentBox.text = ""
        self.commentsTableView.reloadData()
    }
    
}
//this is for first table view, can you have two table views in one view Controller? extend again?
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
            count = (comments?.count)!
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
        network?.postLike(messageID: id!) {
            
        }
    }
    
    func showDetail(message: Message?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LVC = storyboard.instantiateViewController(withIdentifier: "LikesViewController") as! LikesViewController
        LVC.network = self.network
        self.present(LVC, animated: true, completion: nil)
    }
    
}
