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
    func fetchTasksFromJSON()
}

//MARK: - MainPresenter
final class MainPresenter {
    
    //MARK: - Variables
    weak var viewController: MainViewControllerProtocol?
    private var currentDate = Date()
    private var daysArray: [Date?] = []
    private var tasks: [TaskModel] = []
    private var object: [TaskModel] = []
    private var selectedDate = Date()
    private let realmService = RealmService()
    private let calendarManager: CalendarManagerProtocol
    private let moduleBuilder: ModuleBuilder
    private let jsonService: JSONServiceProtocol
    
    init(calendarManager: CalendarManagerProtocol,
         moduleBuilder: ModuleBuilder,
         jsonService: JSONServiceProtocol
    ) {
        self.calendarManager = calendarManager
        self.moduleBuilder = moduleBuilder
        self.jsonService = jsonService
    }
}

//MARK: - MainPresenterProtocol impl
extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        daysArray.removeAll()
        addTasksFromJSONFile()
        
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
    
    func fetchTasksFromJSON() {
        jsonService.fetchTasksFromJSON { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.object = response
                self.viewController?.successResponseFromJSON(response)
            case .failure(let error):
                self.viewController?.failureResponseFromJson(error)
            }
        }
    }
}

//MARK: - NewTaskViewControllerDelegate impl
extension MainPresenter: NewTaskViewControllerDelegate {
    func didSaveNewTask(with taskModel: TaskModel) {
        tasks.append(taskModel)
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
            let timeHour = calendarManager.hourFromFullDate(date: taskModel.dateStart)
            let timeBracket = fetchTimeBracket(with: timeHour)
            let taskViewModel = TaskViewModel(title: taskModel.title,
                                              datetime: taskModel.dateStart,
                                              timeBracket: timeBracket
            )
            let item = Row.task(viewModel: taskViewModel)
            return item
        }
        return tasksViewModel
    }
    
    func fetchTimeBracket(with hourString: String) -> String {
        var hour2: Int = 0
        guard let hour = Int(hourString) else { fatalError() }
        hour2 = hour + 1
        return "\(hour).00 - \(hour2).00"
    }
    
    func fetchFilteredTasks() -> [TaskModel] {
        let filteredArray = tasks.filter { taskModel in
            let day1 = calendarManager.dayNumberFromFullDate(date: taskModel.dateStart)
            let day2 = calendarManager.dayNumberFromFullDate(date: selectedDate)
            
            return day1 == day2
        }
        let dateSorted = filteredArray.sorted { $0.dateStart < $1.dateStart }
        return dateSorted
    }
    
    func fetchAllTasksForAllDays() {
        let realmTaskModel = Array(realmService.read(TaskModelRM.self))
        tasks = realmTaskModel.map { TaskModel(taskRealmModel: $0) }
    }
    
    func addTasksFromJSONFile() {
        fetchTasksFromJSON()
        let objectsFromRealm = Array(realmService.read(TaskModelRM.self))
        let realmObjects = object.map { TaskModelRM(taskModel: $0) }
        checkedTaskFromJSONFile(objectsFromRealm, realmObjects)
    }
    
    func checkedTaskFromJSONFile(_ objectsFromRealm: [TaskModelRM], _ realmObjects: [TaskModelRM]) {
        realmObjects.forEach { realmObject in
            if objectsFromRealm.contains(where: {_ in realmObject.id == realmObject.id}) {
            } else {
                realmService.create(realmObject) { result in
                    switch result {
                    case .success:
                        print("Success created task")
                    case .failure(let error):
                        print("Cant create realm object (Task) \(error.localizedDescription)")
                    }
                }
            }
        }
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

