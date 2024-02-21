//
//  AddListViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import UIKit
import RealmSwift

class AddListViewController: BaseViewController {
    
    let colorSet: [UIColor] = [.red, .systemOrange, .systemYellow,
                               .systemGreen, .systemCyan, .systemBlue,
                               .systemIndigo, .systemRed, .systemPink,
                               .systemBrown, .systemGray, .systemMint]
    
    var listName: String?
    var selectedColor: UIColor? {
        didSet {
            addListTableView.reloadData()
        }
    }
    
    let repository = TodoTableRepository()
    let listRepository = ListTableRepository()
    
     // MARK: - UI Property
    
    let addListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.sectionHeaderHeight = .zero
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.getFileURL()
        configureTableView()
        configureNavigationBar()
    }
    
    override func render() {
        view.addSubview(addListTableView)
        addListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        addListTableView.delegate = self
        addListTableView.dataSource = self
        addListTableView.register(ListTitleTableViewCell.self, forCellReuseIdentifier: ListTitleTableViewCell.identifier)
        addListTableView.register(ListTypeTableViewCell.self, forCellReuseIdentifier: ListTypeTableViewCell.identifier)
        addListTableView.register(ListColorTableViewCell.self, forCellReuseIdentifier: ListColorTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "새로운 목록"
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        if listName == "" || listName == nil {
            self.view.makeToast("목록 이름을 입력해주세요", duration: 2.0, position: .top)
            return
        } else {
            let list = ListTable(regDate: Date(), listName: listName!)
            listRepository.createList(list)
        }
        
        NotificationCenter.default.post(name: AddListViewController.listDidChanged, object: nil)
        
        dismiss(animated: true)
    }
}

// MARK: - UITableView Delegate

extension AddListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AddListCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = AddListCellType(rawValue: indexPath.section) else { return 60 }
        return cellType.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case AddListCellType.listTitle.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTitleTableViewCell.identifier, for: indexPath) as? ListTitleTableViewCell else { return UITableViewCell() }
            
            cell.titleTextField.delegate = self
            
            cell.titleImageView.tintColor = selectedColor
            
            return cell
        case AddListCellType.listType.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTypeTableViewCell.identifier) as? ListTypeTableViewCell else { return UITableViewCell() }
            return cell
        case AddListCellType.listColor.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListColorTableViewCell.identifier, for: indexPath) as? ListColorTableViewCell else { return UITableViewCell() }
            
            // cell collectionView delegate
            cell.colorCollectionView.delegate = self
            cell.colorCollectionView.dataSource = self
            cell.colorCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UICollectionView Delegate

extension AddListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath)
        
        cell.contentView.backgroundColor = colorSet[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = colorSet[indexPath.row]
    }
}

 // MARK: - UITextField Delegate

extension AddListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        listName = textField.text!
        print(listName)
    }
}

 // MARK: -

extension AddListViewController {
    static let listDidChanged = Notification.Name("listDidChanged")
}
