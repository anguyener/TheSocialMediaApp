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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkService().theToken = UserDefaults.standard.string(forKey: "token")
         messages = NetworkService().getMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
      //  messages = network.getMessages()
        greetingLabel.text = "Welcome! Write something to get started."
     //   messageTextField.delegate = self as! UITextFieldDelegate
    }
    
    
//Posts message and resets the text field to the placeholder
    @IBAction func postButtonTapped(_ sender: Any) {
        NetworkService().postMessage(message: Message(user: NetworkService().getName(), text: messageTextField.text!, date: Date(), imgURL: nil, id: nil, replyTo: nil, likedBy: nil))
        messageTextField.text = messageTextField.placeholder
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleViewController else { return }
        guard let source = sender as? MessageCell else { return }
        destination.message = source.message
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
        
        cell.configure(messages![indexPath.item])
        return cell
    }
    
}
