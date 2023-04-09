//
//  TaskDetailViewController.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

protocol TaskDetailViewControllerProtocol: AnyObject {

}

final class TaskDetailViewController: UIViewController {
    
    private var presenter: TaskDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

extension TaskDetailViewController: TaskDetailViewControllerProtocol {

}

private extension TaskDetailViewController {
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
