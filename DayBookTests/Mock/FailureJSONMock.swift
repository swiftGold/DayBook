//
//  FailureJSONMock.swift
//  DayBookTests
//
//  Created by Сергей Золотухин on 16.04.2023.
//

import Foundation
@testable import DayBook

class FailureJSONMock: JSONServiceProtocol {
    func encode(with model: [DayBook.TaskModel]) -> String {
        return ""
    }
    
    func fetchTasksFromJSON(completion: @escaping (Result<[DayBook.TaskModel], Error>) -> Void) {
        let error = NSError(domain: "My Code Domain", code: -777)
        completion(.failure(error))
    }
}
