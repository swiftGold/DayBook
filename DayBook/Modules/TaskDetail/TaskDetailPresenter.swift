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
    
    private var detailViewModel: DetailTaskViewModel
    private let calendarManager: CalendarManagerProtocol
    
    init(calendarManager: CalendarManagerProtocol,
         detailViewModel: DetailTaskViewModel
    ) {
        self.calendarManager = calendarManager
        self.detailViewModel = detailViewModel
    }
}

extension TaskDetailPresenter: TaskDetailPresenterProtocol {
    func viewDidLoad() {
        let model = detailViewModel
        viewController?.updateUI(with: model)
    }
}
