//
//  Message.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/14/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import Foundation

struct Message: Codable {
    let user: String
    let text: String
    let date: Date
    let imgURL: URL?
    let id: String?
    let replyTo: String?
    let likedBy: [String]?
}
