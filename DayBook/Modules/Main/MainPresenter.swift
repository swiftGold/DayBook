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
    func didTapCell(at index: Int)
    func didTapAddTaskButton()
}

//MARK: - MainPresenter
final class MainPresenter {
    weak var viewController: MainViewControllerProtocol?
    
    private var currentDate = Date()
    private var daysArray: [Date?] = []
    
    private var selectedDate = Date() {
        didSet {
            print(selectedDate)
        }
    }
    
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
        let calendarViewModel = fetchViewModel()
        viewController?.updateTableView(with: calendarViewModel)
    }
    
    func didTapPreviousMonthButton() {
        currentDate = calendarManager.minusMonth(date: currentDate)
        viewDidLoad()
    }
    
    func didTapNextMonth() {
        currentDate = calendarManager.plusMonth(date: currentDate)
        viewDidLoad()
    }
    
    func didTapCell(at index: Int) {
        guard let date = daysArray[index] else {
            return
        }
        selectedDate = date
        viewDidLoad()
    }
    
    func didTapAddTaskButton() {
        let newViewController = moduleBuilder.buildNewTaskModule()
        viewController?.routeToNewTaskViewController(newViewController)
    }
}

//MARK: - Private methods
private extension MainPresenter {
    func fetchViewModel() -> CalendarViewModel {
        let days = daysArray.map { day -> DayViewModel in
            let isSelected = calendarManager.isDatesEqual(firstDate: selectedDate, secondDate: day)
            return DayViewModel(title: calendarManager.dayNumberFromFullDate(date: day), isSelected: isSelected)
        }
        let title = fetchMonthYearTitle()
        let calendarViewModel = CalendarViewModel(title: title, days: days)
        return calendarViewModel
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
