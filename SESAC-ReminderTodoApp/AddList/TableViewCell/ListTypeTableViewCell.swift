//
//  ListTypeTableViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import UIKit

class ListTypeTableViewCell: BaseTableViewCell {
    
    let typeIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "list.bullet.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let typeTitle: UILabel = {
        let label = UILabel()
        label.text = "목록 유형"
        return label
    }()
    
    let typeButton: UIButton = {
        let button = UIButton()
        button.setTitle("표준", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    override func render() {
        contentView.addSubview(typeIcon)
        typeIcon.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(35)
        }
        
        contentView.addSubview(typeTitle)
        typeTitle.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(typeIcon.snp.trailing).offset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        contentView.addSubview(typeButton)
        typeButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
