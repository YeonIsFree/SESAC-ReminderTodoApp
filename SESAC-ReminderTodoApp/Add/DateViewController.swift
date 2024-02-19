//
//  DateViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class DateViewController: BaseViewController, PassDataDelegate {
    
    var changedValue: ((String) -> Void)?
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = .now
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changedValue?(DateFormatter.convertToString(datePicker.date))
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
}
