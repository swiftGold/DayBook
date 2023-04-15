//
//  TaskModelRM.swift
//  DayBook
//
//  Created by Сергей Золотухин on 11.04.2023.
//

import RealmSwift

final class TaskModelRM: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var descrip: String = ""
    @objc dynamic var dateStart: Date = Date()
    @objc dynamic var dateFinish: Date = Date()
        
    convenience init(taskModel: TaskModel) {
        self.init()
        id = taskModel.id
        title = taskModel.title
        descrip = taskModel.description
        dateStart = taskModel.dateStart
        dateFinish = taskModel.dateFinish
    }
}
