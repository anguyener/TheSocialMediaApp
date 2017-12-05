//
//  ContactsViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    
    var contacts: [String]? = []
    var network = NetworkService()
    
    @IBOutlet var contactsTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        network.theToken = UserDefaults.standard.string(forKey: "token")
        contacts = network.getUserList() { (result) in
            self.contacts = result
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTable.dataSource = self
       // contacts = network.getUserList()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DirectViewController else { return }
        guard let source = sender as? String else { return } //does this need to be contactCell and add global to contactCell and init?
        destination.recipient = source
        destination.network = network
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts![indexPath.item]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.nameLabel.text = contact
        return cell
    }
    
    //add cell delegate to direct
}
