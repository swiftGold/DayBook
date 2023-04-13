//
//  ViewController.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

//MARK: - MainViewControllerProtocol
protocol MainViewControllerProtocol: AnyObject {
    func updateTableView(with model: [SectionViewModel])
    func routeToNewTaskViewController(_ viewController: UIViewController)
    func routeToTaskDetailViewController(_ viewController: UIViewController)
}

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    private var sectionsViewModel: [SectionViewModel] = []
    
    //MARK: - UI
    private lazy var tableView = make(UITableView()) {
        $0.delegate = self
        $0.dataSource = self
        $0.register(CalendarTableViewCell.self,
                    TaskTableViewCell.self
        )
        $0.backgroundColor = .clear
    }
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

//MARK: MainViewControllerProtocol impl
extension MainViewController: MainViewControllerProtocol {
    func updateTableView(with model: [SectionViewModel]) {
        sectionsViewModel = model
        tableView.reloadData()
    }
    
    func routeToNewTaskViewController(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func routeToTaskDetailViewController(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}

//MARK: - UITableViewDelegate impl
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapTaskCell(at: indexPath.item)
    }
}

//MARK: - UITableViewDataSource impl
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsViewModel[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let rowType = sectionsViewModel[section].rows[row]
        
        switch rowType {
            
        case .calendar(viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(withType: CalendarTableViewCell.self, for: indexPath)
            cell.delegate = self
            cell.configureCell(with: viewModel)
            return cell
        case .task(viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(withType: TaskTableViewCell.self, for: indexPath)
            cell.configureCell(with: viewModel)
            return cell
        }
    }
}

extension MainViewController: CalendarTableViewCellDelegate {
    func didTapCell(at index: Int) {
        presenter?.didTapCalendarCell(at: index)
    }
    
    func didTapPreviousMonthButton() {
        presenter?.didTapPreviousMonthButton()
    }
    
    func didTapNextMonthButton() {
        presenter?.didTapNextMonth()
    }
    
    func didTapAddTaskButton() {
        presenter?.didTapAddTaskButton()
    }
}

//MARK: - private methods
private extension MainViewController {
    func setupViewController() {
        view.backgroundColor = UIColor(named: "customBackground")
        addSubviews()
        setConstraints()
        
        presenter?.viewDidLoad()
    }
    
    func addSubviews() {
        view.myAddSubView(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

