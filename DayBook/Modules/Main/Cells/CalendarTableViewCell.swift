//
//  CalendarTableViewCell.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

//MARK: - CalendarTableViewCell
final class CalendarTableViewCell: UITableViewCell {
    
//MARK: - UI
    private lazy var previousMonthButton = make(UIButton(type: .system)) {
        let image = UIImage(named: "arrow.backward.circle")
        $0.addTarget(self, action: #selector(didTapPreviourMonthButton), for: .touchUpInside)
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    private let titleLabel = make(UILabel()) {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "January/2023"
    }
    
    private lazy var nextMonthButton = make(UIButton(type: .system)) {
        let image = UIImage(named: "arrow.right.circle")
        $0.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    private lazy var stackView = make(UIStackView()) {
        $0.distribution = .fillEqually
    }
    
    private lazy var layout = make(UICollectionViewFlowLayout()) {
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.scrollDirection = .vertical
    }
    
    private lazy var collectionView = make(UICollectionView(frame: .zero, collectionViewLayout: layout)) {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.bounces = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(CalendarViewCell.self, forCellWithReuseIdentifier: "CalendarViewCell")
    }
    
    private lazy var addTaskButton = make(UIButton(type: .system)) {
        $0.addTarget(self, action: #selector(didTapAddTaskButton), for: .touchUpInside)
        $0.setTitle("Add task", for: .normal)
        $0.tintColor = .black
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        
    }
    
//MARK: - Objc methods
    @objc
    private func didTapPreviourMonthButton() {
        print(#function)
    }
    
    @objc
    private func didTapNextMonthButton() {
        print(#function)
    }
    
    @objc
    private func didTapAddTaskButton() {
        print(#function)
    }
}

//MARK: - UICollectionViewDelegate impl
extension CalendarTableViewCell: UICollectionViewDelegate {}

//MARK: - UICollectionViewDataSource impl
extension CalendarTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarViewCell", for: indexPath) as? CalendarViewCell else { fatalError() }
        cell.configureCell()
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CalendarTableViewCell: UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(
                width: (UIScreen.main.bounds.width - 20) / 7,
                height: 25
            )
        }
}

//MARK: - private methods
private extension CalendarTableViewCell {
    func setupStackView() {
        daysOfWeek.forEach {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .black
            label.text = $0
            label.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(label)
        }
    }
    
    func setupCell() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        selectionStyle = .none
        
        contentView.myAddSubView(previousMonthButton)
        contentView.myAddSubView(titleLabel)
        contentView.myAddSubView(nextMonthButton)
        contentView.myAddSubView(stackView)
        contentView.myAddSubView(collectionView)
        contentView.myAddSubView(addTaskButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            previousMonthButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            previousMonthButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: previousMonthButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nextMonthButton.centerYAnchor.constraint(equalTo: previousMonthButton.centerYAnchor),
            nextMonthButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 160),
            
            addTaskButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            addTaskButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addTaskButton.heightAnchor.constraint(equalToConstant: 40),
            addTaskButton.widthAnchor.constraint(equalToConstant: 200),

            //TODO: - сделать автонастройку высоты
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: addTaskButton.bottomAnchor, constant: 20)
        ])
    }
}
