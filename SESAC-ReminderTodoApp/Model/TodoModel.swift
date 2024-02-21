//
//  TodoModel.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import Foundation
import RealmSwift
import UIKit

class FolderTable: Object {
    @Persisted(primaryKey: true) var folderID: ObjectId
    @Persisted var regDate: Date
    @Persisted var folderName: String
    @Persisted var folderType: String // 일단 안씀
//    @Persisted var listColor: UIColor
    
    @Persisted var todoTableList: List<TodoTable>
    
    convenience init(regDate: Date, folderName: String) {
        self.init()
        self.regDate = Date()
        self.folderName = folderName
//        self.listColor = listColor
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
    
    @Persisted(originProperty: "todoTableList") var folder: LinkingObjects<FolderTable>
    
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
