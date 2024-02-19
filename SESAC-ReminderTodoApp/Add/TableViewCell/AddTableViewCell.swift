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
    
    let cellImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Cell Configuration Method
    
    func configureCell(_ index: Int) {
        let cellType = AddCellType(rawValue: index)
        cellTitleLabel.text = cellType?.title
        
        cellImageView.isHidden = (cellType == .addImage) ? false : true
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
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
