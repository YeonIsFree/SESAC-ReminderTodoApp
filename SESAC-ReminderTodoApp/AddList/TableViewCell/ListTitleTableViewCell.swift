//
//  ListTitleTableViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import UIKit

class ListTitleTableViewCell: BaseTableViewCell {

    let titleImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "list.bullet.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "목록 이름"
        textField.textAlignment = .center
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = .zero
        textField.backgroundColor = .systemBackground
        textField.font = .boldSystemFont(ofSize: 22)
        return textField
    }()
    
    override func render() {
        contentView.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(contentView)
            make.size.equalTo(100)
        }
        
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }

}
