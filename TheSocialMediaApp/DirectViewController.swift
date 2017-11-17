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
    
    let network = NetworkService(token: UserDefaults.value(forKey: "token") as! Token)
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var directTable: UITableView!
    
    @IBOutlet weak var directTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directTable.dataSource = self
        directs = network.getDirect()
        
        toLabel.text = //name clicked on... known by delegate?
        directTextView.delegate = self as! UITextViewDelegate
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        network.postDirect(directM: Direct(to: toLabel.text, from: , message: directTextView.text))
        directTextView.delete(<#T##sender: Any?##Any?#>)
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
