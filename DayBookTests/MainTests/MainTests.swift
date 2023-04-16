//
//  MainTests.swift
//  DayBookTests
//
//  Created by Сергей Золотухин on 16.04.2023.
//

import XCTest
@testable import DayBook

final class MainTests: XCTestCase {
    
    var sut: MainPresenter!
    var spyViewController: MainViewProtocolSpy!
    
    override func setUpWithError() throws {
        let viewController = MainViewProtocolSpy()
        let calendarManager = CalendarManager()
        let moduleBuilder = ModuleBuilder()
        let jsonService = JSONService()
        let presenter = MainPresenter(
            calendarManager: calendarManager,
            moduleBuilder: moduleBuilder,
            jsonService: jsonService
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        sut = presenter
        spyViewController = viewController
    }
    
    override func tearDownWithError() throws {
        sut = nil
        spyViewController = nil
    }
    
    func testSuccessFetchTasks() {
        //Given
        let title = "Job"
        //When
        sut.fetchTasksFromJSON()
        //Then
        XCTAssertTrue(spyViewController.isSuccessResponseFromJSON, "bad test result from JSON file")
        XCTAssertEqual(spyViewController.response.first?.title, title, "bad test result from JSON file")
    }
    
    func testFailureFetchTasks() {
        //Given
        let jsonService = FailureJSONMock()
        let calendarManager = CalendarManager()
        let moduleBuilder = ModuleBuilder()
        let presenter = MainPresenter(
            calendarManager: calendarManager,
            moduleBuilder: moduleBuilder,
            jsonService: jsonService
        )
        presenter.viewController = spyViewController
        spyViewController.presenter = presenter
        sut = presenter
        //When
        sut.fetchTasksFromJSON()
        //Then
        XCTAssertTrue(spyViewController.isFailureResponseFromJSON, "failure response from test")
    }
}
