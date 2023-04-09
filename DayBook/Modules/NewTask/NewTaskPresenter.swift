//
//  NewTaskPresenter.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

protocol NewTaskPresenterProtocol {
    func viewDidLoad()
}

final class NewTaskPresenter {
    weak var viewController: NewTaskViewControllerProtocol?
}

extension NewTaskPresenter: NewTaskPresenterProtocol {
    func viewDidLoad() {
        
    }
}
