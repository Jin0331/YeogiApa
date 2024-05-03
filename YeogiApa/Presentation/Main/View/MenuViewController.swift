//
//  MenuViewController.swift
//  YeogiApa
//
//  Created by JinwooLee on 5/3/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class MenuViewController: UIViewController {

    private var datasource : MenuDataSource!
    
    private let headerTitle = UILabel().then {
        $0.font = DesignSystem.mainFont.medium
        $0.backgroundColor = .clear
        $0.text = "Bulletin Board"
        $0.textColor = DesignSystem.commonColorSet.white
        $0.textAlignment = .center
    }
    
    lazy var menuCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.backgroundColor = DesignSystem.commonColorSet.lightBlack
        view.allowsMultipleSelection = false
        view.isScrollEnabled = false
        
       return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        updateSnapshot(MenuCase.allCases)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    
    private func configureHierarchy() {
        [headerTitle, menuCollectionView].forEach { view.addSubview($0)}
    }
    
    private func configureLayout() {
        
        headerTitle.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView() {
        view.backgroundColor = DesignSystem.commonColorSet.lightBlack
    }
}

//MARK: - Collection View 관련
extension MenuViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        // Cell
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    private func menuCellRegistration() -> MenuCellRegistration  {
        
        return MenuCellRegistration { cell, indexPath, itemIdentifier in
            cell.updateUI(itemIdentifier)
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = menuCellRegistration()
        datasource = UICollectionViewDiffableDataSource(collectionView: menuCollectionView, cellProvider: {collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.updateUI(itemIdentifier)
            
            return cell
        })
    }
    
    private func updateSnapshot(_ data : [MenuCase]) {
        
        var snapshot = MenuDataSourceSnapshot()
        snapshot.appendSections(MenuViewSection.allCases)
        
        let uniqueItemsToAdd = data.filter { !snapshot.itemIdentifiers.contains($0) }
        snapshot.appendItems(uniqueItemsToAdd, toSection: .main)
        
        datasource.apply(snapshot)
    }
}
