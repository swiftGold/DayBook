//
//  ModuleBuilder.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

protocol ModuleBuilderProtocol {
    
    func buildNewTaskModule() -> NewTaskViewController
    func buildTaskDetailModule() -> TaskDetailViewController
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
    
    func buildNewTaskModule() -> NewTaskViewController {
        
        let viewController = NewTaskViewController()
        let presenter = NewTaskPresenter()
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildTaskDetailModule() -> TaskDetailViewController {
        
        let viewController = TaskDetailViewController()
        let presenter = TaskDetailPresenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
