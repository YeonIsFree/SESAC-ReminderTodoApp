//
//  DateFormatter.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import Foundation

extension DateFormatter {
    
    static let formatter = DateFormatter()
    
    static func convertToString(_ date: Date) -> String {
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
    
    static func convertToDate(_ date: String) -> Date? {
        return formatter.date(from: date)
    }
}
