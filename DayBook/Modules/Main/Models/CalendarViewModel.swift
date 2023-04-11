//
//  CalendarViewModel.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

struct CalendarViewModel {
    let title: String
    let days: [DayViewModel]
}

struct DayViewModel {
    let title: String
    let isSelected: Bool
}
