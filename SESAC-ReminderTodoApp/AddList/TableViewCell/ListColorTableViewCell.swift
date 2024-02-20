//
//  ListColorTableViewCell.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/21.
//

import UIKit

class ListColorTableViewCell: BaseTableViewCell {

    lazy var colorCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureFlowLayout())
        return view
    }()
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 8
        let cellWidth = (deviceWidth - spacing * 8 ) / 7
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func render() {
        contentView.addSubview(colorCollectionView)
        colorCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
