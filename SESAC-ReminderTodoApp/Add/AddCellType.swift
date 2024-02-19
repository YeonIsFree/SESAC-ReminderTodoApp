//
//  AddCellType.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import Foundation

enum AddCellType: Int, CaseIterable {
    case todoMemo
    case todoDate
    case todoTag
    case priority
    case addImage
    
    var title: String {
        switch self {
        case .todoMemo:
            return ""
        case .todoDate:
            return "마감일"
        case .todoTag:
            return "태그"
        case .priority:
            return "우선 순위"
        case .addImage:
            return "이미지 추가"
        }
    }
    
    var viewController: PassDataDelegate? {
        switch self {
        case .todoMemo:
            return nil
        case .todoDate:
            return DateViewController()
        case .todoTag:
            return TagViewController()
        case .priority:
            return PriorityViewController()
        case .addImage:
            return nil
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .todoMemo:
            return 200
        default:
            return 60
        }
    }
}
