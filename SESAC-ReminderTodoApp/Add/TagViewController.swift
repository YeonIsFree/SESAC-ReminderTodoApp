//
//  TagViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class TagViewController: BaseViewController, PassDataDelegate {
    
    var changedValue: ((String) -> Void)?

    let tagTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "태그를 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changedValue?(tagTextField.text!)
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(tagTextField)
        tagTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(60)
        }
    }
}
