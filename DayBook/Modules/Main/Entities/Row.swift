//
//  Row.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

enum Row {
    case calendar(viewModel: CalendarViewModel)
    case task(viewModel: [TaskViewModel])
}

