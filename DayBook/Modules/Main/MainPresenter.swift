//
//  MainPresenter.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import Foundation
import RealmSwift

//MARK: - MainPresenterProtocol
protocol MainPresenterProtocol {
    func viewDidLoad()
    func didTapPreviousMonthButton()
    func didTapNextMonth()
    func didTapCalendarCell(at index: Int)
    func didTapTaskCell(at index: Int)
    func didTapAddTaskButton()
}

//MARK: - MainPresenter
final class MainPresenter {
    weak var viewController: MainViewControllerProtocol?
    
    private var currentDate = Date()
    private var daysArray: [Date?] = []
    private var tasks: [TaskModel] = []
    
    private var selectedDate = Date() {
        didSet {
            print(selectedDate)
        }
    }
    
    private let realmService = RealmService()
    private let calendarManager: CalendarManagerProtocol
    private let moduleBuilder: ModuleBuilder
    
    init(calendarManager: CalendarManagerProtocol,
         moduleBuilder: ModuleBuilder
    ) {
        self.calendarManager = calendarManager
        self.moduleBuilder = moduleBuilder
    }
}

//MARK: - MainPresenterProtocol impl
extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        daysArray.removeAll()
        let daysInMonth = calendarManager.daysInMonth(date: currentDate)
        guard let firstDayOfMonth = calendarManager.firstOfMonth(date: currentDate) else { return }
        let startingSpaces = calendarManager.weekDay(date: firstDayOfMonth)
        fetchDaysCalendarStructure(startingSpaces, daysInMonth, firstDayOfMonth)
        fetchAllTasksForAllDays()
            
        let calendarViewModel = fetchCalendarViewModel()
        let taskViewModel = fetchTaskViewModel()
        
        let sectionViewModel: [SectionViewModel] = [
            SectionViewModel(type: .calendar,
                             rows: [.calendar(viewModel: calendarViewModel)]
                            ),
            SectionViewModel(type: .task,
                             rows: taskViewModel
                            )
        ]
        
        viewController?.updateTableView(with: sectionViewModel)
    }
    
    func didTapPreviousMonthButton() {
        currentDate = calendarManager.minusMonth(date: currentDate)
        viewDidLoad()
    }
    
    func didTapNextMonth() {
        currentDate = calendarManager.plusMonth(date: currentDate)
        viewDidLoad()
    }
    
    func didTapCalendarCell(at index: Int) {
        guard let date = daysArray[index] else {
            return
        }
        selectedDate = date
        viewDidLoad()
    }
    
    func didTapAddTaskButton() {
        let newViewController = moduleBuilder.buildNewTaskModule(delegate: self)
        viewController?.routeToNewTaskViewController(newViewController)
    }
    
    func didTapTaskCell(at index: Int) {
        let filteredArray = fetchFilteredTasks()
        let model = filteredArray[index]
        let start = calendarManager.timeFromFullDate(date: model.dateStart)
        let finish = calendarManager.timeFromFullDate(date: model.dateFinish)
        
        let detailViewModel = DetailTaskViewModel(title: model.title, description: model.description, startTime: start, finishTime: finish)
        
        let newViewController = moduleBuilder.buildTaskDetailModule(detailViewModel)
        viewController?.routeToTaskDetailViewController(newViewController)
    }
}

//MARK: - NewTaskViewControllerDelegate impl
extension MainPresenter: NewTaskViewControllerDelegate {
    func didSaveNewTask(with taskModel: TaskModel) {
        tasks.append(taskModel)
        print(tasks)
        viewDidLoad()
    }
}

//MARK: - Private methods
private extension MainPresenter {
    func fetchCalendarViewModel() -> CalendarViewModel {
        let days = daysArray.map { day -> DayViewModel in
            let isSelected = calendarManager.isDatesEqual(firstDate: selectedDate, secondDate: day)
            return DayViewModel(title: calendarManager.dayNumberFromFullDate(date: day), isSelected: isSelected)
        }
        let title = fetchMonthYearTitle()
        let calendarViewModel = CalendarViewModel(title: title, days: days)
        return calendarViewModel
    }
    
    func fetchTaskViewModel() -> [Row] {
        let filteredArray = fetchFilteredTasks()
        let tasksViewModel = filteredArray.map { taskModel -> Row in
            let taskViewModel = TaskViewModel(title: taskModel.title,
                                              datetime: taskModel.dateStart
            )
            let item = Row.task(viewModel: taskViewModel)
            return item
        }
        return tasksViewModel
    }
    
    func fetchFilteredTasks() -> [TaskModel] {
        let filteredArray = tasks.filter { taskModel in
            let day1 = calendarManager.dayNumberFromFullDate(date: taskModel.dateStart)
            let day2 = calendarManager.dayNumberFromFullDate(date: selectedDate)
            
            return day1 == day2
        }
        return filteredArray
    }
    
    func fetchAllTasksForAllDays() {
        let realmTaskModel = Array(realmService.read(TaskModelRM.self))
        tasks = realmTaskModel.map { TaskModel(taskRealmModel: $0) }
    }
    
    func fetchDaysCalendarStructure(_ startingSpaces: Int, _ daysInMonth: Int, _ firstDayOfMonth: Date) {
        var count: Int = 1
        
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                daysArray.append(nil)
            } else {
                let value = count - startingSpaces
                let date = Calendar.current.date(byAdding: .day, value: value, to: firstDayOfMonth)
                daysArray.append(date)
            }
            count += 1
        }
    }
    
    func fetchMonthYearTitle() -> String {
        let monthString = calendarManager.monthString(date: currentDate)
        let yearString = calendarManager.yearString(date: currentDate)
        let title = monthString + " / " + yearString
        return title
    }
}
