//
//  CalendarViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

final class CalendarViewCell: UICollectionViewCell {
    
    let titleLabel = make(UILabel()) {
        $0.textColor = UIColor(named: "customGreen")
        $0.font = UIFont.boldSystemFont(ofSize: 18)
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
    }
}

private extension CalendarViewCell {
    func setupCell() {
        myAddSubView(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
