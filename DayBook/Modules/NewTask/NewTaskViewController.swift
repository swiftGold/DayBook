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
    }
    
    private let finishDateLabel = make(UILabel()) {
        $0.textColor = .black
        $0.text = "Choose finish time"
    }
    
    private lazy var finishDatePicker = make(UIDatePicker()) {
        $0.datePickerMode = .dateAndTime
        $0.tintColor = .black
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
}

//MARK: - NewTaskViewControllerProtocol
extension NewTaskViewController: NewTaskViewControllerProtocol {
    func createNewTask(with model: TaskModel) {
        delegate?.didSaveNewTask(with: model)
        dismiss(animated: true)
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



//let dateFormatter = DateFormatter()
//let date = Date()
//
//let timeStamp = date.timeIntervalSince1970
//print(timeStamp)
//
//let dateFromUnix = Date(timeIntervalSince1970: timeStamp)
//print(dateFromUnix)
//
//dateFormatter.dateFormat = "MM dd YYYY HH:mm"
//dateFormatter.timeZone = .current
//let date1 = dateFormatter.string(from: dateFromUnix)
//print(date1)


//let realm = try! Realm()
//private var categories: Results<Category>?
//private var selectedCategory = Category()
//private var toDoItems: Results<Item>?


//@objc
//private func didTapAddTaskButton() {
//
//    //сохраняем категорию в виде модели
//    selectedCategory.name = "job"
////        self.save(category: selectedCategory)
////        print(realm.objects(Category.self))
//
//    //берем модель категории из рилма
//    let currentCategory = realm.objects(Category.self)[0]
//
//    //добавляем модель в массив категории
////        do {
////            try self.realm.write {
////                let newItem = Item()
////                newItem.title = "111"
////                newItem.done = true
////                currentCategory.items.append(newItem)
////            }
////        } catch {
////            print(error)
////        }
////        print(currentCategory)
//
//    //сортируем в массиве категории модели по имени title
//    toDoItems = currentCategory.items.sorted(byKeyPath: "title", ascending: true)
////        toDoItems?.forEach({ item in
////            print(item.title)
////        })
//
//    //Обновляем данные свойства модели из массива категории
////        if let item = toDoItems?[0] {
////            do {
////                try realm.write {
////                    item.title = "999"
////                }
////            } catch {
////                print(error)
////            }
////        }
//
//    //Удаляем модель из массива (в скобочках указываем indexpath.row)
////        if let item = toDoItems?[1] {
////            do {
////                try realm.write {
////                    realm.delete(item)
////                }
////            } catch {
////                print(error)
////            }
////        }
//    toDoItems = currentCategory.items.sorted(byKeyPath: "title", ascending: true)
//    toDoItems?.forEach({ item in
//        print(item.title)
//        print(item.done)
//    })
//
//    //поиск в searchBar
////        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
//}

//func save(category: Category) {
//    do {
//        try realm.write {
//            realm.add(category)
//        }
//    } catch {
//        print(error.localizedDescription)
//    }
//}
