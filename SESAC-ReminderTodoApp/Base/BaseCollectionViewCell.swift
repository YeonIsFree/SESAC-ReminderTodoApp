//
//  BaseCollectionViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - UI Configuration Method
    
    func render() { }
    
    func configureView() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .secondarySystemBackground
    }
}
