//
//  TaskModel.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import Foundation

struct TaskModel: Codable {
    let id: UUID
    let title: String
    let description: String
    let dateStart: Date
    let dateFinish: Date
    
    init(
        //при создании новой модели, id создается по умолчанию в инициализаторе
        id: UUID = UUID(),
        title: String,
        description: String,
        dateStart: Date,
        dateFinish: Date
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.dateStart = dateStart
        self.dateFinish = dateFinish
    }
    
    init(taskRealmModel: TaskModelRM) {
        self.id = taskRealmModel.id
        self.title = taskRealmModel.title
        self.description = taskRealmModel.descrip
        self.dateStart = taskRealmModel.dateStart
        self.dateFinish = taskRealmModel.dateFinish
    }
}
