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
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priorityLabel, titleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var dateTagStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, tagLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, memoLabel, dateTagStackView])
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
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
     // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration Methods
    
    func configureTodoCell(_ todo: TodoTable) {
        contentView.backgroundColor = .clear
        
        titleLabel.text = todo.todoTitle
        memoLabel.text = todo.todoMemo
        dateLabel.text = DateFormatter.convertToString(todo.date)
        
        // tag
        if todo.tag != "" {
            tagLabel.text = "#\(todo.tag)"
        }
        
        // priority
        priorityLabel.text = priorityString(rawValue: todo.priority)?.labelString
        
        // complete 체크 버튼
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
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
        }

    }
}

 // MARK: - Notification

extension DetailListViewController {
    static let completeListDidChange = Notification.Name("completeListDidChange")
}
