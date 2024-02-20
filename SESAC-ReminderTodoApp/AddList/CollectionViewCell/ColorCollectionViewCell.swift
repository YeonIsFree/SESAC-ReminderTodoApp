//
//  ColorCollectionViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import UIKit

class ColorCollectionViewCell: BaseCollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.bounds.width / 2
    }
}
