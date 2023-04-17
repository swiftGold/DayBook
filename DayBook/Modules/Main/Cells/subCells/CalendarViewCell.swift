//
//  CalendarViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

final class CalendarViewCell: UICollectionViewCell {
    
    private let titleLabel = make(UILabel()) {
        $0.textColor = UIColor(named: "customGreen")
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    
    private let taskView = make(UIView()) {
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: DayViewModel) {
        titleLabel.text = "\(viewModel.title)"
        titleLabel.textColor = viewModel.isSelected ? UIColor(named: "customRed") : UIColor(named: "customPurple")
        taskView.backgroundColor = viewModel.isTasked ? UIColor(named: "customRed") : .clear
    }
}

private extension CalendarViewCell {
    func setupCell() {
        myAddSubView(titleLabel)
        myAddSubView(taskView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            taskView.bottomAnchor.constraint(equalTo: bottomAnchor),
            taskView.heightAnchor.constraint(equalToConstant: 2),
            taskView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            taskView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
