//
//  JSONTaskModel.swift
//  DayBook
//
//  Created by Сергей Золотухин on 13.04.2023.
//

struct JSONTaskModel: Decodable {
    let id: String
    let title: String
    let description: String
    let dateStart: Double
    let dateFinish: Double
}
