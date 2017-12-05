//
//  MessageCell.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/17/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

protocol MessageCellDelegate {
    func performLike(id: String?)
    func showDetail(message: Message?)
}

class MessageCell: UITableViewCell {
    
    var message: Message?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var numButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var delegate: MessageCellDelegate?
    
    func configure(_ with: Message, delegate: MessageCellDelegate) {
        self.delegate = delegate
        message = with
        nameLabel.text = message!.user//with.user
        dateLabel.text = DateFormatter.localizedString(from: message!.date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
        messageLabel.text = message!.text
        numButton.setTitle(String(describing: message!.likedBy!.capacity), for: UIControlState.normal) //normal? is that ok for highlighted and selected...
        likeButton.setTitle("Like", for: UIControlState.normal)
        // likeButton.setTitle("Liked", for: UIControlState.selected)
        
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likeButton.setTitle("Liked", for: UIControlState.normal)
        numButton.setTitle(String(describing: (message!.likedBy?.capacity)!+1), for: UIControlState.normal)
        delegate?.performLike(id: message?.id)
        message?.likedBy?.append(UserDefaults.standard.string(forKey: "username")!)
    }
    
    @IBAction func numButtonTapped(_ sender: Any) { //Message cell sends to new view controller?
        delegate?.showDetail(message: message)
    }
}
