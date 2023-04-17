//
//  NewTaskViewController.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit
import RealmSwift

//MARK: - NewTaskViewControllerDelegate
protocol NewTaskViewControllerDelegate: AnyObject {
    func didSaveNewTask(with taskModel: TaskModel)
}

//MARK: - NewTaskViewControllerProtocol
protocol NewTaskViewControllerProtocol: AnyObject {
    func createNewTask(with model: TaskModel)
    func dateError()
    func changeSecondTimePickerValue(with date: Date)
    func updateSelectedDate(_ date: Date)
}

//MARK: - NewTaskViewController
final class NewTaskViewController: UIViewController {
    //MARK: - UI
    private let taskNameLabel = make(UILabel()) {
        $0.textColor = .black
        $0.text = "Enter task name"
    }
    
    private lazy var taskNameTextField = make(UITextField()) {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "customPurple")?.cgColor
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let startDateLabel = make(UILabel()) {
        $0.textColor = .black
        $0.text = "Choose start time"
    }
    
    private lazy var startDatePicker = make(UIDatePicker()) {
        $0.datePickerMode = .dateAndTime
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didChangeDatePickerValue), for: .valueChanged)
        $0.locale = Locale(identifier: "en_GB")
    }
    
    private let finishDateLabel = make(UILabel()) {
        $0.textColor = .black
        $0.text = "Choose finish time"
    }
    
    private lazy var finishDatePicker = make(UIDatePicker()) {
        $0.datePickerMode = .dateAndTime
        $0.tintColor = .black
        $0.locale = Locale(identifier: "en_GB")
    }
    
    private let descriptionLabel = make(UILabel()) {
        $0.textColor = .black
        $0.text = "Enter a description of your task"
    }
    
    private lazy var descriptionTextView = make(UITextView()) {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "customPurple")?.cgColor
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private lazy var addTaskButton = make(UIButton(type: .system)) {
        $0.addTarget(self, action: #selector(didTapAddTaskButton), for: .touchUpInside)
        $0.setTitle("Add task", for: .normal)
        $0.tintColor = UIColor(named: "customBackground")
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = UIColor(named: "customPurple")
        $0.layer.borderWidth = 1.4
        $0.layer.borderColor = UIColor(named: "customPurple")?.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private let stackView = make(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    //MARK: - Properties
    var presenter: NewTaskPresenterProtocol?
    weak var delegate: NewTaskViewControllerDelegate?
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    //MARK: - Objc methods
    @objc
    private func didTapAddTaskButton() {
        guard let title = taskNameTextField.text,
              let description = descriptionTextView.text else
        {
            print("title or description is not found")
            return
        }
        let startDate = startDatePicker.date
        let finishDate = finishDatePicker.date
        
        presenter?.addTaskButtonTapped(title: title,
                                       description: description,
                                       startDate: startDate,
                                       finishDate: finishDate
        )
    }
    
    @objc
    private func didChangeDatePickerValue() {
        let startDate = startDatePicker.date
        presenter?.didChangeDatePickerValue(date: startDate)
    }
}

//MARK: - NewTaskViewControllerProtocol
extension NewTaskViewController: NewTaskViewControllerProtocol {
    func createNewTask(with model: TaskModel) {
        delegate?.didSaveNewTask(with: model)
        dismiss(animated: true)
    }
    
    func dateError() {
        finishDateLabel.text = "Finish date should to be more then start date"
        finishDateLabel.textColor = UIColor(named: "customRed")
    }
    
    func changeSecondTimePickerValue(with date: Date) {
        finishDatePicker.date = date
    }
    
    func updateSelectedDate(_ date: Date) {
        startDatePicker.date = date
        finishDatePicker.date = date
    }
}

//MARK: - Private methods
private extension NewTaskViewController {
    func setupViewController() {
        view.backgroundColor = .lightGray
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor(named: "customBackground")
        
        stackView.addArrangedSubview(taskNameLabel)
        stackView.addArrangedSubview(taskNameTextField)
        stackView.addArrangedSubview(startDateLabel)
        stackView.addArrangedSubview(startDatePicker)
        stackView.addArrangedSubview(finishDateLabel)
        stackView.addArrangedSubview(finishDatePicker)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(addTaskButton)
        
        view.myAddSubView(stackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
}
