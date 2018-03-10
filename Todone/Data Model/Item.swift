//
//  Item.swift
//  Todone
//
//  Created by Josh Gressman on 3/7/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import Foundation

class Item: Encodable {
    var title: String = ""
    var done: Bool = false
}
