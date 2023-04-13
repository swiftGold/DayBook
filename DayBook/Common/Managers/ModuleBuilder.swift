//
//  ModuleBuilder.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

protocol ModuleBuilderProtocol {
    
    func buildNewTaskModule(delegate: NewTaskViewControllerDelegate) -> NewTaskViewController
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
                
        let presenter = MainPresenter(calendarManager: calendarManager, moduleBuilder: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    //добавялем делегат для создания новой таски
    func buildNewTaskModule(delegate: NewTaskViewControllerDelegate) -> NewTaskViewController {
        
        let viewController = NewTaskViewController()
        let presenter = NewTaskPresenter()
        
        viewController.delegate = delegate
        viewController.presenter = presenter
        presenter.viewController = viewController
        
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
