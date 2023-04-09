//
//  MainPresenter.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

//MARK: - MainPresenterProtocol
protocol MainPresenterProtocol {
    func viewDidLoad()
}

//MARK: - MainPresenter
final class MainPresenter {
    weak var viewController: MainViewControllerProtocol?
}

//MARK: - MainPresenterProtocol impl
extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        
    }
}

//MARK: - Private methods
private extension MainPresenter {
    
}
