//
//  MyListViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import UIKit
import RealmSwift

class FolderViewController: BaseViewController, PassDataDelegate {
    
    var changedValue: ((String) -> Void)? // 여기서는 안씁니다.
    
    var selectedFolder: ((FolderTable) -> Void)?
    
    let listRepository = FolderTableRepository()
    var folderList: Results<FolderTable>!
    
     // MARK: - UI Property
    
    let myListTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .systemBackground
        return view
    }()
    
     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        folderList = listRepository.fetchFolderList()
        
        configureTableView()
    }
    
    override func render() {
        view.addSubview(myListTableView)
        myListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
     // MARK: - Configuration Method
    
    private func configureTableView() {
        myListTableView.delegate = self
        myListTableView.dataSource = self
        myListTableView.register(ListTypeTableViewCell.self, forCellReuseIdentifier: ListTypeTableViewCell.identifier)
    }
}

 // MARK: - UITableView Delegate

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTypeTableViewCell.identifier, for: indexPath) as? ListTypeTableViewCell else { return UITableViewCell() }
        
        let listItem = folderList[indexPath.row]
        cell.typeTitle.text = listItem.folderName
        cell.typeButton.setTitle("", for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFolder?(folderList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
