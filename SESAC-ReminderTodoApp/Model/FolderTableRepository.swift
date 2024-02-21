//
//  TodoListTableRepository.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import Foundation
import RealmSwift

final class FolderTableRepository {
    
    private let realm = try! Realm()
    
     // MARK: - Create
    
    func createList(_ folder: FolderTable) {
        do {
            try realm.write {
                realm.add(folder)
                print("Realm Saved--")
            }
        } catch {
            print(error)
        }
    }
    
     // MARK: - Read
    
    func fetchFolderList() -> Results<FolderTable> {
        return realm.objects(FolderTable.self)
    }
}
