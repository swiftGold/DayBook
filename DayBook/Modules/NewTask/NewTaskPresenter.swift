//
//  NewTaskPresenter.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import Foundation
import RealmSwift

protocol NewTaskPresenterProtocol {
    func addTaskButtonTapped(title: String, description: String, startDate: Date, finishDate: Date)
    func didChangeDatePickerValue(date: Date)
    func updateSelectedDate(date: Date)
}

final class NewTaskPresenter {
    weak var viewController: NewTaskViewControllerProtocol?
    
    private let realmService = RealmService()
    private let calendarManager: CalendarManagerProtocol
    init(calendarManager: CalendarManagerProtocol) {
        self.calendarManager = calendarManager
    }
}

extension NewTaskPresenter: NewTaskPresenterProtocol {
    func addTaskButtonTapped(title: String, description: String, startDate: Date, finishDate: Date) {
        
        if startDate > finishDate {
            viewController?.dateError()
        } else {
            let taskModel = TaskModel(
                title: title,
                description: description,
                dateStart: startDate,
                dateFinish: finishDate
            )
            
            let object = TaskModelRM(taskModel: taskModel)
            
            realmService.create(object) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    print("Success created task")
                    self.viewController?.createNewTask(with: taskModel)
                case .failure(let error):
                    print("Cant create realm object (Task) \(error.localizedDescription)")
                }
            }
        }
    }
    
    func didChangeDatePickerValue(date: Date) {
        let date = calendarManager.plus30minutes(date: date)
        viewController?.changeSecondTimePickerValue(with: date)
    }
    
    func updateSelectedDate(date: Date) {
        viewController?.updateSelectedDate(date)
    }
}
