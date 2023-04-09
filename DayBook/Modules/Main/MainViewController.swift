//
//  ViewController.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func updateTableView()
    func routeToNewTaskViewController(_ viewController: UIViewController)
    func routeToTaskDetailViewController(_ viewController: UIViewController)
}

final class MainViewController: UIViewController {
    
    private var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

extension MainViewController: MainViewControllerProtocol {
    func updateTableView() {
        
    }
    
    func routeToNewTaskViewController(_ viewController: UIViewController) {
        
    }
    
    func routeToTaskDetailViewController(_ viewController: UIViewController) {
        
    }
}

private extension MainViewController {
    func setupViewController() {
        view.backgroundColor = .lightGray
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
}

