//
//  TaskDetailViewController.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

// MARK: - TaskDetailViewControllerProtocol
protocol TaskDetailViewControllerProtocol: AnyObject {
    func updateUI(with detailViewModel: DetailTaskViewModel)
}

final class TaskDetailViewController: UIViewController {
// MARK: - UI
    private let titleLabel = make(UILabel()) {
        $0.numberOfLines = 0
        $0.text = "title"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "customRed")
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1.4
        $0.layer.borderColor = UIColor(named: "customPurple")?.cgColor
    }
    
    private let startTimeLabel = make(UILabel()) {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "start"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "customRed")
    }
    
    private let dashLabel = make(UILabel()) {
        $0.text = "-"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "customRed")
    }
    
    private let finishTimeLabel = make(UILabel()) {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "finish"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "customRed")
    }
    
    private let descriptionLabel = make(UILabel()) {
        $0.numberOfLines = 0
        $0.text = "description"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "customRed")
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1.4
        $0.layer.borderColor = UIColor(named: "customPurple")?.cgColor
    }
    
    private let timeStackView = make(UIStackView()) {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    private let mainStackView = make(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
// MARK: - Properties
    var presenter: TaskDetailPresenterProtocol?
    
// MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - TaskDetailViewControllerProtocol
extension TaskDetailViewController: TaskDetailViewControllerProtocol {
    func updateUI(with detailViewModel: DetailTaskViewModel) {
        titleLabel.text = detailViewModel.title
        descriptionLabel.text = detailViewModel.description
        startTimeLabel.text = detailViewModel.startTime
        finishTimeLabel.text = detailViewModel.finishTime
    }
}

// MARK: - Private methods
private extension TaskDetailViewController {
    func setupViewController() {
        view.backgroundColor = UIColor(named: "customBackground")
        addSubviews()
        setConstraints()
        presenter?.viewDidLoad()
    }
    
    func addSubviews() {
        timeStackView.addArrangedSubview(startTimeLabel)
        timeStackView.addArrangedSubview(dashLabel)
        timeStackView.addArrangedSubview(finishTimeLabel)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(timeStackView)
        mainStackView.addArrangedSubview(descriptionLabel)
        view.myAddSubView(mainStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
    }
}
