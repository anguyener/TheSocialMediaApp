//
//  ContactsViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    var contacts: [String]? = []
    var network: NetworkService?
    
    @IBOutlet var contactsTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        network?.theToken = UserDefaults.standard.string(forKey: "token")
        self.contacts = self.network?.getUserList() { (result) in
            DispatchQueue.main.async {
                self.contacts = result
                self.contactsTable.reloadData()
            }
        }
        //  contactsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTable.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DirectViewController else { return }
        guard let source = sender as? ContactCell else { return } //does this need to be contactCell and add global to contactCell and init?
        destination.recipient = source.name
        destination.network = network
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.configure(contacts![indexPath.item])
        return cell
    }
    
    //add cell delegate to direct?
}
