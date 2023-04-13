//
//  TaskTableViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    //MARK: - UI
    private let titleLabel = make(UILabel()) {
        $0.numberOfLines = 0
    }
    
    private let datetimeLabel = make(UILabel()) {
        $0.text = ""
    }
    
    //MARK: - Properties
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
        
        guard let date = viewModel?.datetime else { return }
        let time = calendarManager.timeFromFullDate(date: date)
        
        datetimeLabel.text = time
        titleLabel.text = model.title

        print(model.datetime)
    }
}

// MARK: - Private methods
private extension TaskTableViewCell {
    func setupCell() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        myAddSubView(titleLabel)
        myAddSubView(datetimeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: datetimeLabel.leadingAnchor, constant: -8),
            
            datetimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            datetimeLabel.widthAnchor.constraint(equalToConstant: 100),
            datetimeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
}
