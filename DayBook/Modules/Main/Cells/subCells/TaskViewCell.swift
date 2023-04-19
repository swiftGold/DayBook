//
//  TaskTableViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

final class TaskViewCell: UITableViewCell {
    
// MARK: - UI
    private let timeBracketLabel = make(UILabel()) {
        $0.textColor = UIColor(named: Colors.red)
    }
    
    private let titleLabel = make(UILabel()) {
        $0.numberOfLines = 0
        $0.textColor = UIColor(named: Colors.purple)
    }
    
    private let datetimeLabel = make(UILabel()) {
        $0.textColor = UIColor(named: Colors.purple)
    }
    
// MARK: - Variables
    private var viewModel: TaskViewModel?
    private let calendarManager = CalendarManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: TaskViewModel) {
        viewModel = model
        timeBracketLabel.text = viewModel?.timeBracket
        guard let date = viewModel?.datetime else { return }
        let time = calendarManager.timeFromFullDate(date: date)
        datetimeLabel.text = time
        titleLabel.text = viewModel?.title
    }
}

// MARK: - Private methods
private extension TaskViewCell {
    func setupCell() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        myAddSubView(timeBracketLabel)
        myAddSubView(titleLabel)
        myAddSubView(datetimeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            timeBracketLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeBracketLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            timeBracketLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            timeBracketLabel.widthAnchor.constraint(equalToConstant: 120),
            
            titleLabel.leadingAnchor.constraint(equalTo: timeBracketLabel.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: timeBracketLabel.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: datetimeLabel.leadingAnchor, constant: -8),
            
            datetimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            datetimeLabel.widthAnchor.constraint(equalToConstant: 50),
            datetimeLabel.centerYAnchor.constraint(equalTo: timeBracketLabel.centerYAnchor)
        ])
    }
}
