//
//  TaskTableViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    private let titleLabel = make(UILabel()) {
        $0.numberOfLines = 0
        $0.text = "Сделать что-то"
    }
    
    private let datetimeLabel = make(UILabel()) {
        $0.text = "01:30"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
      
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
