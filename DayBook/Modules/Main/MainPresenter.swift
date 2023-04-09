//
//  MainPresenter.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

protocol MainPresenterProtocol {
    func viewDidLoad()
}

final class MainPresenter {
    weak var viewController: MainViewControllerProtocol?
}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        
    }
}
