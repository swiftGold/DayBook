//
//  MainViewProtocolSpy.swift
//  DayBookTests
//
//  Created by Сергей Золотухин on 16.04.2023.
//

@testable import DayBook
import UIKit

class MainViewProtocolSpy: MainViewControllerProtocol {
    var presenter: MainPresenterProtocol?
    var response: [TaskModel] = []
    var isSuccessResponseFromJSON = false
    var isFailureResponseFromJSON = false
        
    func successResponseFromJSON(_ response: [DayBook.TaskModel]) {
        isSuccessResponseFromJSON = true
        self.response = response
    }
    
    func failureResponseFromJson(_ error: Error) {
        isFailureResponseFromJSON = true
    }
    
    func updateTableView(with model: [DayBook.SectionViewModel]) {
        
    }
    
    func routeToNewTaskViewController(_ viewController: UIViewController) {
        
    }
    
    func routeToTaskDetailViewController(_ viewController: UIViewController) {
        
    }
}
