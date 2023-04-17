//
//  DetailTaskViewModel.swift
//  DayBook
//
//  Created by Сергей Золотухин on 11.04.2023.
//

import Foundation

struct DetailTaskViewModel {
    var id: UUID = UUID()
    let title: String
    let description: String
    let startTime: String
    let finishTime: String
    
    init(title: String,
         description: String,
         startTime: String,
         finishTime: String
    ) {
        self.title = title
        self.description = description
        self.startTime = startTime
        self.finishTime = finishTime
    }
}
