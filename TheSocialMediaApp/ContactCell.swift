//
//  ContactCell.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/17/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var name: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(_ with: String) {
        name = with
        nameLabel.text = name
    }
    
    
    
}
