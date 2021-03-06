//
//  HomeViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var messages: [Message]? = []
    var network: NetworkService?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        network?.theToken = UserDefaults.standard.string(forKey: "token")
        messages = network!.getMessages() { (result) in
            DispatchQueue.main.async { // -__-
                self.messages = result.filter({ $0.replyTo == nil}).sorted(by: { $0.date.compare($1.date) == .orderedDescending})
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        greetingLabel.text = "Welcome! Write something to get started."
    }
    
    //Posts message and resets the text field to the placeholder
    @IBAction func postButtonTapped(_ sender: Any) {
        network?.postMessage(message: Message(user: network!.getName(), text: messageTextField.text!, date: Date(), imgURL: nil, id: nil, replyTo: nil, likedBy: nil)) {
            DispatchQueue.main.async {
                self.viewWillAppear(true)
            }
        }
        messageTextField.text = ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let destination = segue.destination as? SingleViewController else { return }
            guard let source = sender as? MessageCell else { return }
            destination.message = source.message
            destination.network = self.network!
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        cell.configure(messages![indexPath.item],delegate: self) //index out of range when switch back from contacts
        return cell
    }
}

extension HomeViewController: MessageCellDelegate {
    
    func performLike(id: String?) {
        DispatchQueue.main.async { //sync- exc bad instruction
            self.network?.postLike(messageID: id!) {}
            self.tableView.reloadData()
        }
    }
    
    func showDetail(message: Message?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let likesViewController = storyboard.instantiateViewController(withIdentifier: "LikesViewController") as! LikesViewController //?
        likesViewController.network = self.network
        likesViewController.message = message
        navigationController?.pushViewController(likesViewController, animated: true)
    }    
}
