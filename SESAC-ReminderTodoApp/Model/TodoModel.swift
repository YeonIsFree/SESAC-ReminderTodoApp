//
//  TodoModel.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import Foundation
import RealmSwift

class TodoListTable: Object {
    @Persisted(primaryKey: true) var listID: ObjectId
    @Persisted var regDate: Date
    @Persisted var listName: String
    
    @Persisted var todoTableList: List<TodoTable>
    
    convenience init(regDate: Date, listName: String) {
        self.init()
        self.regDate = Date()
        self.listName = listName
    }
}

class TodoTable: Object {
    @Persisted(primaryKey: true) var todoID: ObjectId
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
