//
//  TaskTableViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 18.04.2023.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func didTapTaskCell(at index: Int)
}

final class TaskTableViewCell: UITableViewCell {
    
    private lazy var tableView = make(UITableView()) {
        $0.delegate = self
        $0.dataSource = self
        $0.register(TaskViewCell.self)
        $0.backgroundColor = .clear
    }
    
    weak var delegate: TaskTableViewCellDelegate?
    private var taskViewModels: [TaskViewModel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModels: [TaskViewModel]) {
        taskViewModels = viewModels
        tableView.reloadData()
    }
}

extension TaskTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("table did tap at CELL \(indexPath.item)")
        let index = indexPath.row
        delegate?.didTapTaskCell(at: index)
    }
}

extension TaskTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: TaskViewCell.self, for: indexPath)
        let model = taskViewModels[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - private methods
private extension TaskTableViewCell {
    func setupTableViewCell() {
        addSubviews()
        setConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func addSubviews() {
        contentView.myAddSubView(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

