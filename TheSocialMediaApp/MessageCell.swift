//
//  MessageCell.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/17/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var message: Message?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var numButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    func configure(_ with: Message) {
        message = with
        nameLabel.text = message!.user//with.user
        
        DateFormatter.dateFormat(fromTemplate: "MMM dd, yyyy", options: 0, locale: Locale(identifier: "en_US"))
        dateLabel.text = "now"//DateFormatter.string(message.date)
        
        messageLabel.text = message!.text
        numButton.setTitle(String(describing: message!.likedBy?.capacity), for: UIControlState.normal) //normal? is that ok for highlighted and selected...
        likeButton.setTitle("Like", for: UIControlState.normal)
        // likeButton.setTitle("Liked", for: UIControlState.selected)
        
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likeButton.setTitle("Liked", for: UIControlState.normal)
        numButton.setTitle(String(describing: (message!.likedBy?.capacity)!+1), for: UIControlState.normal)
    }
    
    @IBAction func numButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LikesViewController = storyboard.instantiateViewController(withIdentifier: "LikesViewController") as! LikesViewController
      //  present(LikesViewController, animated: true, completion: nil) //needs to be in a delegate?
        LikesViewController.present(LikesViewController, animated: true, completion: nil)
    }
    
}
