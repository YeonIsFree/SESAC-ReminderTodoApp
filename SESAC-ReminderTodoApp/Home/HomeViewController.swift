//
//  HomeViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/19.
//

import UIKit

final class HomeViewController: BaseViewController {
    
     // MARK: - UI Properties
    
    private lazy var todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, 
                                              collectionViewLayout: configureFlowLayout())
        return collectionView
    }()
    
    private let toolBar = UIToolbar()
    
     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureToolBar()
    }
    
     // MARK: - UI Configuration Methods
    
    override func render() {
        view.addSubview(todoCollectionView)
        todoCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
        let addListButton = UIBarButtonItem()
        addListButton.title = "목록 추가"
        
        toolBar.items = [addButton, space, addListButton]
        toolBar.tintColor = .white
    }
    
    @objc func addButtonTapped() {
        let nav = UINavigationController(rootViewController: AddViewController())
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
        
        return cell
    }
}
