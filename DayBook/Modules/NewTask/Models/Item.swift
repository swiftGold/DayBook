//
//  Item.swift
//  DayBook
//
//  Created by Сергей Золотухин on 10.04.2023.
//

import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
