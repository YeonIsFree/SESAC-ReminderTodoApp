//
//  BaseViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit
import SnapKit
import Toast

class BaseViewController: UIViewController {
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        render()
        configureGlobalNavigation()
        showToast()
    }
    
    func render() { }
    
    func configureGlobalNavigation() {
        navigationItem.titleView?.tintColor = .white
    }
    
    func showToast() { }
}
