//
//  TaskRealmModel.swift
//  DayBook
//
//  Created by Сергей Золотухин on 11.04.2023.
//

import RealmSwift

class TaskRealmModel: Object {
    @objc dynamic var taskName: String = ""
    @objc dynamic var taskDateStart: Date = Date()
    @objc dynamic var taskDateFinish: Date = Date()
    @objc dynamic var taskValue: String = ""

    convenience init(
            taskName: String,
            taskDateStart: Date,
            taskDateFinish: Date,
            taskValue: String
    )
        {
            self.init()
            self.taskName = taskName
            self.taskDateStart = taskDateStart
            self.taskDateFinish = taskDateFinish
            self.taskValue = taskValue
        }
}
