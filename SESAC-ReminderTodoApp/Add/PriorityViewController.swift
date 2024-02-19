//
//  CompletedViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

class PriorityViewController: BaseViewController, PassDataDelegate {
    
    var changedValue: ((String) -> Void)?
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["나중", "보통", "중요"])
        control.addTarget(self, action: #selector(segConTapped), for: .valueChanged)
        return control
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let idx = segmentedControl.selectedSegmentIndex
        if let priority = segmentedControl.titleForSegment(at: idx) {
            changedValue?(priority)
            
            // 값이 변경되었다고 Noti
//            NotificationCenter.default.post(name: PriorityViewController.priorityDidChanged, object: nil, userInfo: ["todoPriority": priority])
        }
    }
    
     // MARK: - UI Configuration Method
    
    @objc func segConTapped() {
        navigationController?.popViewController(animated: true)
    }
 
    override func render() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
    }
}
