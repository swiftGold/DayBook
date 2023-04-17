//
//  ModuleBuilder.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import Foundation

protocol ModuleBuilderProtocol {
    func buildNewTaskModule(delegate: NewTaskViewControllerDelegate, _ selectedDate: Date) -> NewTaskViewController
    func buildTaskDetailModule(_ detailViewModel: DetailTaskViewModel) -> TaskDetailViewController
    func buildRootModule() -> MainViewController
}

final class ModuleBuilder {
    private let calendarManager: CalendarManagerProtocol
    
    init() {
        calendarManager = CalendarManager()
    }
}

extension ModuleBuilder: ModuleBuilderProtocol {
    func buildRootModule() -> MainViewController {
        let viewController = MainViewController()
        let jsonService = JSONService()
        let realmService = RealmService()
        let presenter = MainPresenter(
            calendarManager: calendarManager,
            moduleBuilder: self,
            jsonService: jsonService,
            realmService: realmService
        )
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    //добавялем делегат для создания новой таски
    func buildNewTaskModule(delegate: NewTaskViewControllerDelegate, _ selectedDate: Date) -> NewTaskViewController {
        let viewController = NewTaskViewController()
        let calendarManager = CalendarManager()
        let realmService = RealmService()
        let presenter = NewTaskPresenter(
            calendarManager: calendarManager,
            realmService: realmService
        )
        viewController.delegate = delegate
        viewController.presenter = presenter
        presenter.viewController = viewController
        viewController.presenter?.updateSelectedDate(date: selectedDate)
        return viewController
    }
    
    func buildTaskDetailModule(_ detailViewModel: DetailTaskViewModel) -> TaskDetailViewController {
        let viewController = TaskDetailViewController()
        let calendarManager = CalendarManager()
        let presenter = TaskDetailPresenter(
            calendarManager: calendarManager,
            detailViewModel: detailViewModel
        )
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
