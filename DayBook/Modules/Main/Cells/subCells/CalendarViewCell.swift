//
//  CalendarViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

final class CalendarViewCell: UICollectionViewCell {
    
    let titleLabel = make(UILabel()) {
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        titleLabel.text = "99"
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
