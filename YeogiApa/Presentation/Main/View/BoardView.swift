//
//  BoardView.swift
//  YeogiApa
//
//  Created by JinwooLee on 4/18/24.
//

import UIKit
import Then
import SnapKit
import NVActivityIndicatorView

final class BoardView: BaseView {

    let questionButton = CompleteButton(title: "작성하기", image: DesignSystem.sfSymbol.question, fontSize: 15)
    
    lazy var mainCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.backgroundColor = DesignSystem.commonColorSet.white
        view.allowsMultipleSelection = true
        view.isPagingEnabled = true
        
       return view
    }()
    
    // Loading
    lazy var loadingBgView: UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        bgView.backgroundColor = .clear
        
        return bgView
    }()
    
    lazy var activityIndicator: NVActivityIndicatorView = {
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60),
                                                        type: .ballPulseSync,
                                                        color: DesignSystem.commonColorSet.lightBlack,
                                                        padding: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    
    
    override func configureHierarchy() {
        addSubview(mainCollectionView)
        addSubview(questionButton)
    }
    
    override func configureLayout() {
        questionButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.width.equalTo(110)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

//MARK: - Collection View 관련
extension BoardView {
    
    private func createLayout() -> UICollectionViewLayout {
        
        // Cell
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    func boardCellRegistration() -> BoardCellRegistration  {
        
        return BoardCellRegistration { cell, indexPath, itemIdentifier in
            cell.updateUI(itemIdentifier)
        }
    }
}

//MARK: - Indicator
extension BoardView {
    func setActivityIndicator() {
        // 불투명 뷰 추가
        addSubview(loadingBgView)
        // activity indicator 추가
        loadingBgView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // 애니메이션 시작
        activityIndicator.startAnimating()
    }
}
