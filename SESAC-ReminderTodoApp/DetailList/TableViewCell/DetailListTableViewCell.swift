//
//  DetailListTableViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class DetailListTableViewCell: BaseTableViewCell {

    let repository = TodoTableRepository()
    
    var todo: TodoTable?
    
     // MARK: - UI Properties
    
    let checkButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        return label
    }()
    
    lazy var dateTagStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, tagLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, memoLabel, dateTagStackView])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - UI Configuration Methods
    
    func configureTodoCell(_ todo: TodoTable) {
        contentView.backgroundColor = .clear
        
        titleLabel.text = todo.todoTitle
        memoLabel.text = todo.todoMemo
        dateLabel.text = DateFormatter.convertToString(todo.date)
        
        if todo.tag != "" {
            tagLabel.text = "#\(todo.tag)"
        }
        priorityLabel.text = todo.priority
        
        let image = (todo.isCompleted) ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        checkButton.setImage(image, for: .normal)
    }
    
    // MARK: - Selector
    
    @objc
    private func checkButtonTapped() {
        if let todo {
            repository.updateCompleteStatus(todo)
            let image = (todo.isCompleted) ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
            checkButton.setImage(image, for: .normal)
            
            // CompleteList 값이 변경됨을 알림
            NotificationCenter.default.post(name: DetailListViewController.completeListDidChange, object: nil)
        }
    }
    
    override func render() {
        contentView.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        contentView.addSubview(cellStackView)
        cellStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
        }
        
        contentView.addSubview(priorityLabel)
        priorityLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(cellStackView.snp.trailing)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
    }
}

 // MARK: - Notification

extension DetailListViewController {
    static let completeListDidChange = Notification.Name("completeListDidChange")
}
