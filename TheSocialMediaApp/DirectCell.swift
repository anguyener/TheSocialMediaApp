//
//  DirectCell.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/17/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class DirectCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    func configure(_ with: Direct) {
        messageLabel.text = with.message.text
        
        likeButton.setTitle("Like", for: UIControlState.normal)
        likeButton.setTitle("Liked", for: UIControlState.selected)
    }
    
}
