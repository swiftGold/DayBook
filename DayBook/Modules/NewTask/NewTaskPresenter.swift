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
}

final class NewTaskPresenter {
    weak var viewController: NewTaskViewControllerProtocol?
    
    private let realmService = RealmService()
}

extension NewTaskPresenter: NewTaskPresenterProtocol {
    func addTaskButtonTapped(title: String, description: String, startDate: Date, finishDate: Date) {
        
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
                //TODO: - delete after
//                print(Array(self.realmService.read(TaskModelRM.self)))
                self.viewController?.createNewTask(with: taskModel)
            case .failure(let error):
                print("Cant create realm object (Task) \(error.localizedDescription)")
            }
        }
    }
}
