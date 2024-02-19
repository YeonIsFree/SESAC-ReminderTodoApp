//
//  Identifiable.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/19.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: Identifiable { }
