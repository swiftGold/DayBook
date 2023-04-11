//
//  Category.swift
//  DayBook
//
//  Created by Сергей Золотухин on 10.04.2023.
//

import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
