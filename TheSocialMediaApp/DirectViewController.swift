//
//  DirectViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class DirectViewController: UIViewController {
    
    var directs: [Direct] = []
    var recipient: String?
    var network: NetworkService?
    // let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var directTable: UITableView!
    
    @IBOutlet weak var directTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        network!.theToken = UserDefaults.standard.string(forKey: "token")
        directs = network!.getDirect() { (result) in
            self.directs = result.sorted(by: { $0.message.date.compare($1.message.date) == .orderedDescending})
            self.directTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directTable.dataSource = self        
        toLabel.text = recipient!//name clicked on... known by delegate?
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        network!.postDirect(directM: Direct(to: toLabel.text!, from: network!.getName(),
                                           message: Message(user: network!.getName(), text: directTextField.text!, date: Date(), imgURL: nil, id: nil, replyTo: toLabel.text!, likedBy: nil))) {
                                            DispatchQueue.main.async {
                                                self.viewWillAppear(true)
                                            }
        }
        directTextField.text = directTextField.placeholder
    }
}

extension DirectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectCell") as! DirectCell
        
        cell.configure(directs[indexPath.item])
        return cell
    }
}
