//
//  Item.swift
//  Todone
//
//  Created by Josh Gressman on 3/7/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import Foundation

//Codeable signafies that the code is able to be encoded/saved and decoded/extracted
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
