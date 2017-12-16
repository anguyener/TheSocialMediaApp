//
//  DirectCell.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/17/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class DirectCell: UITableViewCell {
    
    var word: Direct?
    
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(_ with: Direct) {
        word = with
        messageLabel.text = word?.message.text
    }
    
}
