//
//  NewTaskViewController.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

protocol NewTaskViewControllerProtocol: AnyObject {

}

final class NewTaskViewController: UIViewController {
    
    private var presenter: NewTaskPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

extension NewTaskViewController: NewTaskViewControllerProtocol {

}

private extension NewTaskViewController {
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
