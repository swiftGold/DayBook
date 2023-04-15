//
//  PostService.swift
//  DayBook
//
//  Created by Сергей Золотухин on 13.04.2023.
//

import Foundation
import SwiftyJSON

final class PostService {
    
    func encode(with model: [TaskModel]) -> String {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(model) else { fatalError() }
        guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { fatalError() }
        return json
    }
    
    func encodeFromJson(with model: JSON) -> String {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(model) else { fatalError() }
        guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { fatalError() }
        return json
    }
    
    func fetchTasksFromJSON() -> [TaskModel] {
        guard let jsonFromFile = getJsonFromFile() else { fatalError() }
        let json = JSON(jsonFromFile)
        let jsonString = encodeFromJson(with: json)
        guard let object = decode(with: jsonString) else { fatalError() }
        return object
    }

    func decode(with jsonString: String) -> [TaskModel]? {
        if let jsonData = jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                let tasks = try decoder.decode([TaskModel].self, from: jsonData)
                return tasks
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getJsonFromFile() -> JSON? {
        guard let path = Bundle.main.path(forResource: "JSONModel", ofType: "json") else { fatalError() }
        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
//            print(json)
            return json
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
