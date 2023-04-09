//
//  ModuleBuilder.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

final class ModuleBuilder {
    
    private let calendarManager: CalendarManagerProtocol
    
    init() {
        calendarManager = CalendarManager()
    }
}
