//
//  HomeCollectionViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .white
        return imageView
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    // MARK: - Cell UI Configuration Method
    
    func configureCell(_ index: Int) {
        iconImageView.image = HomeCellType(rawValue: index)!.image
        titleLable.text = HomeCellType(rawValue: index)!.title
    }
    
    override func render() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.size.equalTo(32)
        }
        
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView).offset(5)
            make.height.equalTo(14)
        }
        
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(32)
        }
    }
}
