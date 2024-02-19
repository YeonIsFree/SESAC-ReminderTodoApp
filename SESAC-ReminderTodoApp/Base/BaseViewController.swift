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
        render()
        configureGlobalNavigation()
        showToast()
    }
    
    func render() { }
    
    func configureGlobalNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView?.tintColor = .white
    }
    
    func showToast() { }
}
