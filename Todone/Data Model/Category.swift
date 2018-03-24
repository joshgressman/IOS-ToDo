//
//  Category.swift
//  Todone
//
//  Created by Josh Gressman on 3/24/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import Foundation
import RealmSwift

//The super class that is inherited is the RealmSwift Object class
class Category: Object {
    @objc dynamic var name : String = ""
    //create relationship with items > Foreward relationship
    let items = List<Item>()
}
