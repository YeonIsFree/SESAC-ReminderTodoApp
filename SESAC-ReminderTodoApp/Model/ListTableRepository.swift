//
//  TodoListTableRepository.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import Foundation
import RealmSwift

final class ListTableRepository {
    
    private let realm = try! Realm()
    
     // MARK: - Create
    
    func createList(_ list: ListTable) {
        do {
            try realm.write {
                realm.add(list)
                print("Realm Saved--")
            }
        } catch {
            print(error)
        }
    }
    
     // MARK: - Read
    
    func fetchList() -> Results<ListTable> {
        return realm.objects(ListTable.self)
    }
}
