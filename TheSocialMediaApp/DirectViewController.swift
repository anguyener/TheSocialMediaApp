//
//  DirectViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class DirectViewController: UIViewController {
    
    var directs: [Direct]?
    var recipient: String?
    var network: NetworkService?
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var directTable: UITableView!
    
    @IBOutlet weak var directTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.network!.theToken = UserDefaults.standard.string(forKey: "token")
        self.directs = self.network!.getDirect() { (result) in
            DispatchQueue.main.async {
                self.directs = result.sorted(by: { $0.message.date.compare($1.message.date) == .orderedDescending}).filter { $0.from == self.recipient ||
                    ($0.to == self.recipient && $0.from == self.network?.getName()) }
                self.directTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directTable.dataSource = self        
        toLabel.text = recipient!
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        self.network!.postDirect(directM: Direct(to: toLabel.text!, from: network!.getName(), message: Message(user: network!.getName(), text: directTextField.text!, date: Date(), imgURL: nil, id: nil, replyTo: toLabel.text!, likedBy: nil))) {
                                            DispatchQueue.main.async {
                                                self.viewWillAppear(true)
                                            }
        }
        directTextField.text = ""
        DispatchQueue.main.async {
            self.directTable.reloadData()
        }
    }
}

extension DirectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DirectCell?
        var temp: Direct?
        var color: UIColor?
        cell = tableView.dequeueReusableCell(withIdentifier: "DirectCell") as! DirectCell
        temp = directs?[indexPath.item]
        if temp?.from == recipient {
            color = UIColor.black
        }
        else if temp?.to == recipient {
            color = UIColor.gray
        }
        cell?.configure(temp, color: color ?? UIColor.black)
        return cell!
    }
}
