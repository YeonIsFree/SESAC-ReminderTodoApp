//
//  HomeViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/19.
//

import UIKit
import RealmSwift

final class HomeViewController: BaseViewController {
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    let repository = TodoTableRepository()
    let listRepository = FolderTableRepository()
    
    var folderList: Results<FolderTable>!
    
    // MARK: - UI Properties
    
    private lazy var todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configureFlowLayout())
        return collectionView
    }()
    
    private let listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let toolBar = UIToolbar()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.getFileURL()
        addObserver()
        configureCollectionView()
        configureTableView()
        configureToolBar()
        
        folderList = listRepository.fetchFolderList()
        
    }
    
    // MARK: - Notification Methods
    
    private func addObserver() {
        token = NotificationCenter.default.addObserver(forName: AddViewController.todoListDidChanged,
                                                       object: nil,
                                                       queue: OperationQueue.main,
                                                       using: { [weak self] _ in
            print("List DID CHANGED!")
            self?.todoCollectionView.reloadData()
        })
        
        token = NotificationCenter.default.addObserver(forName: DetailListViewController.completeListDidChange,
                                                       object: nil,
                                                       queue: OperationQueue.main,
                                                       using: { [weak self] _ in
            print("Complete List DID CHANGED!")
            self?.todoCollectionView.reloadData()
        })
        
        token = NotificationCenter.default.addObserver(forName: AddListViewController.listDidChanged,
                                                       object: nil,
                                                       queue: OperationQueue.main,
                                                       using: { [weak self] _ in
            print("List DID CHANGED!")
            self?.listTableView.reloadData()
        })
    }
    
    // MARK: - UI Configuration Methods
    
    override func render() {
        view.addSubview(todoCollectionView)
        todoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(todoCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 13
        let cellWidth = (deviceWidth - spacing * 3 ) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
    private func configureCollectionView() {
        todoCollectionView.delegate = self
        todoCollectionView.dataSource = self
        todoCollectionView.register(HomeCollectionViewCell.self,
                                    forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTypeTableViewCell.self, forCellReuseIdentifier: ListTypeTableViewCell.identifier)
    }
    
    private func configureToolBar() {
        // Left: 미리 알림 추가
        var customView = UIButton.Configuration.plain()
        customView.contentInsets = .zero
        customView.imagePadding = 8
        
        let button = UIButton(configuration: customView)
        button.setTitle("미리 알림 추가", for: .normal)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let addButton = UIBarButtonItem(customView: button)
        
        // 가운데 빈 공간
        let space = UIBarButtonItem.flexibleSpace()
        
        // Right: 목록 추가 버튼
        let addListButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonTapped))
        
        toolBar.items = [addButton, space, addListButton]
        toolBar.tintColor = .white
    }
    
    @objc func addButtonTapped() {
        if folderList.isEmpty {
            view.self.makeToast("목록을 먼저 생성해주세요", position: .center)
            return
        } else {
            let nav = UINavigationController(rootViewController: AddViewController())
            nav.navigationBar.tintColor = .white
            present(nav, animated: true)
        }
    }
    
    @objc func addListButtonTapped() {
        let nav = UINavigationController(rootViewController: AddListViewController())
        nav.navigationBar.tintColor = .white
        present(nav, animated: true)
    }
}

// MARK: - UICollectionView Delegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeCellType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(indexPath.item)
        
        let cellType = HomeCellType.allCases[indexPath.item]
        cell.countLabel.text = "\(repository.fetchTodoList(cellType).count)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailListViewController()
        let cellType = HomeCellType.allCases[indexPath.item]
        vc.cellType = cellType
//        vc.folderName = nil
        vc.navigationItem.title = cellType.title
        vc.navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableView Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTypeTableViewCell.identifier, for: indexPath) as? ListTypeTableViewCell else { return UITableViewCell() }
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        let folder = folderList[indexPath.row]
        cell.typeTitle.text = folder.folderName
        cell.typeButton.setTitle("\(folder.todoTableList.count)", for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailListViewController()
        vc.cellType = HomeCellType.all
        vc.folder = folderList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
