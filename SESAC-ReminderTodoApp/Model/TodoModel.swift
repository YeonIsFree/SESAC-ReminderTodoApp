//
//  TodoModel.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var todoTitle: String
    @Persisted var todoMemo: String
    @Persisted var date: Date
    @Persisted var tag: String
    @Persisted var priority: String
    @Persisted var isCompleted: Bool
    @Persisted var isFlagged: Bool
    
    convenience init(todoTitle: String, todoMemo: String, date: Date, tag: String, priority: String) {
        self.init()
        self.todoTitle = todoTitle
        self.todoMemo = todoMemo
        self.date = date
        self.tag = tag
        self.priority = priority
        self.isCompleted = false
        self.isFlagged = false
    }

}
