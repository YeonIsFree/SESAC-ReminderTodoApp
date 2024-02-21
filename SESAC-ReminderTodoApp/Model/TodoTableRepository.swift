//
//  TodoTableRepository.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import Foundation
import RealmSwift

final class TodoTableRepository {
    
    private let realm = try! Realm()
    
    func getFileURL() {
        print(realm.configuration.fileURL!)
    }
    
    // MARK: - Create
    
    func createTodo(_ todo: TodoTable) {
        do {
            try realm.write {
                realm.add(todo)
                print("Realm Saved-- todo")
            }
        } catch {
            print(error)
        }
    }
    
    func createViaFolder(folder: FolderTable, todo: TodoTable) {
        do {
            try realm.write {
                folder.todoTableList.append(todo)
                print("Realm Saved-- folder")
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Read
    
    func fetchTodoList(_ cellType: HomeCellType) -> Results<TodoTable> {
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        switch cellType {
        case .today:
            return realm.objects(TodoTable.self).where { $0.date >= start && $0.date < end }
        case .scheduled:
            return realm.objects(TodoTable.self).where { $0.date >= end }
        case .all:
            return realm.objects(TodoTable.self)
        case .flag:
            return realm.objects(TodoTable.self).where { $0.isFlagged }
        case .completed:
            return realm.objects(TodoTable.self).where { $0.isCompleted }
        }
    }
    
    func fetchSortedBy(_ keyPath: String) -> Results<TodoTable> {
        return realm.objects(TodoTable.self).sorted(byKeyPath: keyPath)
    }
    
    //    func fetchListByFolder(_ folderName: String) -> Results<TodoTable> {
    //
    //    }
    
    // MARK: - Update
    
    func updateCompleteStatus(_ todo: TodoTable) {
        do {
            try realm.write {
                todo.isCompleted.toggle()
                print("status: ", todo.isCompleted)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Delete
    
    func deleteTodo(_ todo: TodoTable) {
        do {
            try realm.write {
                realm.delete(todo)
            }
        } catch {
            print("delete error", error)
        }
    }
    
}
