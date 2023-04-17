//
//  TaskViewModel.swift
//  DayBook
//
//  Created by Сергей Золотухин on 11.04.2023.
//

import Foundation

struct TaskViewModel {
    let id = UUID()
    let title: String
    let datetime: Date
    let timeBracket: String
}
