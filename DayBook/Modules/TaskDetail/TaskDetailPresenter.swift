//
//  TaskDetailPresenter.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

protocol TaskDetailPresenterProtocol {
    func viewDidLoad()
}

final class TaskDetailPresenter {
    weak var viewController: TaskDetailViewControllerProtocol?
}

extension TaskDetailPresenter: TaskDetailPresenterProtocol {
    func viewDidLoad() {
        
    }
}
