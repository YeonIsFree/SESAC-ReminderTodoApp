//
//  CollectionType.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

enum HomeCellType: Int, CaseIterable {
    case today
    case scheduled
    case all
    case flag
    case completed
    
    var title: String {
        switch self {
        case .today:
            return "오늘"
        case .scheduled:
            return "예정"
        case .all:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .completed:
            return "완료됨"
        }
    }
    
    var image: UIImage {
        switch self {
        case .today:
            return UIImage(systemName: "calendar.circle.fill")!
        case .scheduled:
            return UIImage(systemName: "calendar.circle")!
        case .all:
            return UIImage(systemName: "tray.circle.fill")!
        case .flag:
            return UIImage(systemName: "flag.circle")!
        case .completed:
            return UIImage(systemName: "checkmark.circle.fill")!
        }
    }
}
