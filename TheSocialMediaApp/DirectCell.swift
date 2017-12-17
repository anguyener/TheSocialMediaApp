//
//  DirectCell.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/17/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class DirectCell: UITableViewCell {
    
    var message: Direct?
    
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(_ with: Direct?, color: UIColor) {
        message = with
        messageLabel.text = message?.message.text
        messageLabel.textColor = color
    }
    
}
