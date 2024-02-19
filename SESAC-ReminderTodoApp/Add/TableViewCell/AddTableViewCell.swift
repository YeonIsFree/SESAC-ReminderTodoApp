//
//  AddTableViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class AddTableViewCell: BaseTableViewCell {
    
    // MARK: - UI Properties
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let cellSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "라랄랄"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Cell Configuration Method
    
    func configureCell(_ index: Int) {
        cellTitleLabel.text = AddCellType(rawValue: index)?.title
    }
    
    override func render() {
        contentView.addSubview(cellTitleLabel)
        cellTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).inset(10)
            make.width.equalTo(120)
        }
        
        contentView.addSubview(cellSubTitleLabel)
        cellSubTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
