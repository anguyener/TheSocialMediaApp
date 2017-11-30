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
  //  let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    @IBOutlet weak var singleMessage: UITableView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var commentBox: UITextField!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkService().theToken = UserDefaults.standard.string(forKey: "token")
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
       NetworkService().postMessage(message: Message(user: NetworkService().getName(), text: commentBox.text!, date: Date(), imgURL: nil, id: nil, replyTo: nil, likedBy: nil))
        //commentBox.delete() //how do I clear commentBox?
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
        
        cell.configure(message!) 
        return cell
    }
}
