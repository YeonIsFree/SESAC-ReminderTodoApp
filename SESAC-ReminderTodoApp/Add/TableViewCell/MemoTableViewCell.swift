//
//  MemoTableViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class MemoTableViewCell: BaseTableViewCell {
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        return textField
    }()
    
    let memoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메모"
        return textField
    }()

    // MARK: - UI Configuration Method
    
    override func render() {
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(memoTextField)
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.bottom.equalTo(contentView)
        }
    }
}
