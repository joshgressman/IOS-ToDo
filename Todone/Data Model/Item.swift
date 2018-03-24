//
//  Item.swift
//  Todone
//
//  Created by Josh Gressman on 3/24/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    //relationship with the categories
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
