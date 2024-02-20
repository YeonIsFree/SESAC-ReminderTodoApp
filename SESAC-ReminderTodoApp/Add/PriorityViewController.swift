//
//  CompletedViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

enum priorityString: String, CaseIterable {
    case later = "나중"
    case normal = "보통"
    case important = "중요"
    
    var labelString: String {
        switch self {
        case .later:
            return ""
        case .normal:
            return "!"
        case .important:
            return "!!"
        }
    }
}

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
        
        // 세그먼트를 누르지 않고 뒤로 갔을 경우
        if idx == -1 {
            navigationController?.popViewController(animated: true)
            return
        }
        
        if let priority = segmentedControl.titleForSegment(at: idx) {
            changedValue?(priority)
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
