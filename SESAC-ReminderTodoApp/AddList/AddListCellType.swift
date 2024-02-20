//
//  AddListCellType.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import Foundation

enum AddListCellType: Int, CaseIterable {
    case listTitle
    case listType
    case listColor
    
    var cellHeight: CGFloat {
        switch self {
        case .listTitle:
            return 200
        case .listType:
            return 60
        case .listColor:
            return 150
        }
    }
}
