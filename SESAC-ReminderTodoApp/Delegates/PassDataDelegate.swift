//
//  PassDataDelegates.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

// 화면 간 값 전달을 위한 Delegate

protocol PassDataDelegate where Self: UIViewController {
    var changedValue: ((String) -> Void)? { get set }
}
