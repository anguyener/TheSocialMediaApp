//
//  Direct.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/14/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import Foundation

struct Direct: Codable {
    let to: String
    let from: String
    let message: Message
}
