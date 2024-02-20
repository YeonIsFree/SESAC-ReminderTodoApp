//
//  DetailListViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit
import RealmSwift

class DetailListViewController: BaseViewController {
    
    let repository = TodoTableRepository()
    
    var list: Results<TodoTable>! {
        didSet {
            listTableView.reloadData()
        }
    }
    
    var cellType = HomeCellType.all  // 이전 화면에서 전달된 현재 Cell 타입
    
    // MARK: - UI Properties
    
    let listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    lazy var optionButtonItems: [UIAction] = {
        let orderByDate = UIAction(title: "마감일 순") { _ in
            self.list = self.repository.fetchSortedBy("date")
        }
        
        let orderByTitle = UIAction(title: "제목 순") { _ in
            self.list = self.repository.fetchSortedBy("todoTitle")
        }
        
        let items = [orderByDate, orderByTitle]
        return items
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list = repository.fetchTodoList(cellType)
    }
    
    // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(DetailListTableViewCell.self, forCellReuseIdentifier: DetailListTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        let rightBarButton = UIBarButtonItem()
        rightBarButton.image = UIImage(systemName: "ellipsis.circle")
        rightBarButton.menu = UIMenu(title: "정렬", children: optionButtonItems)
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

// MARK: - UITableView Delegate

extension DetailListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailListTableViewCell.identifier, for: indexPath) as? DetailListTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        let todo = list[indexPath.row]
        cell.todo = todo
        cell.configureTodoCell(todo)
        
        // 이미지 세팅
        cell.photoImageView.image = loadImageFromDocument(filename: "\(todo.todoID)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Swipe Delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let targetTodo = list[indexPath.row]
            
            removeImageFromDocument(filename: "\(targetTodo.todoID)")
            
            repository.deleteTodo(targetTodo)
            tableView.reloadData()
            
            // Home 화면 count 갱신을 위한 Noti post
            NotificationCenter.default.post(name: AddViewController.todoListDidChanged, object: nil)
        }
    }
}
