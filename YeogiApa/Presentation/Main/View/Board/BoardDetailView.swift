//
//  BoardDetailView.swift
//  YeogiApa
//
//  Created by JinwooLee on 4/24/24.
//

import UIKit
import Then
import SnapKit
import STTextView
import Kingfisher

final class BoardDetailView: BaseView {
    
    private let textViewDefaultHeight : Double = 300
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = DesignSystem.commonColorSet.gray
        
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = true
        $0.bounces = false
    }
    
    private let contentsView = UIView().then {
        $0.backgroundColor = DesignSystem.commonColorSet.white
    }
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .heavy)
        $0.numberOfLines = 2
    }
    
    let author = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = DesignSystem.commonColorSet.gray
    }
    
    private let createdAt = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = DesignSystem.commonColorSet.gray
        $0.textAlignment = .left
    }
    
    let commentCountButton = CompleteButton(title: "0", image: DesignSystem.sfSymbol.comment, fontSize: 18).then {
        $0.titleLabel?.numberOfLines = 0
        $0.alignTextBelow2()
        $0.sizeToFit()
    }
    
    lazy var textView = UITextView().then {
        $0.font = .systemFont(ofSize: 18.5, weight: .bold)
        $0.isEditable = false
        $0.delegate = self
        $0.isScrollEnabled = false // 스크롤 비활성화
    }
    
    private let buttonBgView = UIView().then {
        $0.backgroundColor = DesignSystem.commonColorSet.white
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    let likeButton = CompleteButton(title: "0", image: DesignSystem.sfSymbol.like, fontSize: 18).then {
        $0.titleLabel?.numberOfLines = 0
        $0.alignTextBelow2()
        $0.sizeToFit()
    }

    lazy var commentCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.backgroundColor = DesignSystem.commonColorSet.white
        view.allowsMultipleSelection = false
        view.isScrollEnabled = false
        
       return view
    }()
    
    let commentBackgroundView = UIView().then {
        $0.backgroundColor = DesignSystem.commonColorSet.white
    }
    
    let commentCompleteButton = CompleteButton(title: "등록", image: DesignSystem.sfSymbol.comment, fontSize: 14)
    
    let commentTextField = STTextView().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            NSAttributedString.Key.foregroundColor: DesignSystem.commonColorSet.gray
        ]
        $0.attributedPlaceholder = NSAttributedString(string: " 댓글을 남겨주세요.", attributes: attributes)
        $0.placeholderVerticalAlignment = .center
        $0.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        $0.backgroundColor = DesignSystem.commonColorSet.white
        
        $0.addBorder([.top], color: .red, width: 1.0)
    }
    
    override func configureHierarchy() {
        
        [scrollView, commentBackgroundView].forEach { addSubview($0)}
        
        [commentTextField, commentCompleteButton].forEach { commentBackgroundView.addSubview($0) }
        
        scrollView.addSubview(contentsView)
        [title, author, createdAt, textView, buttonBgView, commentCollectionView].forEach { contentsView.addSubview($0) }
        
        buttonBgView.addSubview(buttonStackView)
        [likeButton, commentCountButton].forEach { buttonStackView.addArrangedSubview($0)}
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(commentTextField.snp.top).offset(10)
        }
        
        contentsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.lessThanOrEqualTo(120)
        }
        
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.leading.equalToSuperview().inset(10)
        }
        
        createdAt.snp.makeConstraints { make in
            make.centerY.equalTo(author)
            make.height.equalTo(author)
            make.width.equalTo(130)
            make.leading.equalTo(author.snp.trailing).offset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(200)
        }
        
        buttonBgView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalTo(commentCollectionView.snp.top).offset(-20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(165)
        }
        
        commentCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalToSuperview().inset(10)
        }
        
        commentBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(commentBackgroundView)
            make.trailing.equalTo(commentCompleteButton.snp.leading).offset(-5)
            make.verticalEdges.equalTo(commentBackgroundView).inset(10)
        }
        
        commentCompleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentBackgroundView)
            make.trailing.equalTo(commentBackgroundView).inset(5)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
    }

    func updateUI(_ data : PostResponse) {
        title.text = data.title
        author.text = data.creator.nick
        createdAt.text = data.createdAtToTime
        commentCountButton.setTitle(String(data.comments.count), for: .normal)
        textView.text = data.content1
        addTextViewImage(data)
        
        
        collectionViewchangeLayout(itemCount: data.comments.count)
    }
    
    func commentUpdateUI(_ data : PostResponse) {
        commentCountButton.setTitle(String(data.comments.count), for: .normal)
        collectionViewchangeLayout(itemCount: data.comments.count)
    }
    
    func likeUpdateUI(_ data : PostResponse) {
        likeButton.setTitle(String(data.likes.count), for: .normal)
    }
    
}

//MARK: - TextView 관련
extension BoardDetailView : UITextViewDelegate {
    
    private func addTextViewImage(_ data : PostResponse) {
        //MARK: - 특정 위치에 이미지 넣기
        let urlList = data.filesToUrl
        let imageLocation = data.content3ToImageLocation
        
        if !urlList.isEmpty && !imageLocation.isEmpty {
            (0..<urlList.count).forEach { _addTextViewImage(url: urlList[$0], location: imageLocation[$0])}
        } else if !urlList.isEmpty && imageLocation.isEmpty {
            var testLastLocation = 0
            
            (0..<urlList.count).forEach {
                _addTextViewImage(url: urlList[$0], location: testLastLocation)
                testLastLocation += 1
            }
        }
    }
    
    private func _addTextViewImage(url : URL, location: Int) {
        
        KingfisherManager.shared.downloader.downloadImage(with: url, options: [.requestModifier(AuthManager.kingfisherAuth())] ) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let imageResult):
                // 이미지 다운로드 성공 시 NSAttributedString을 만들어서 UITextView에 삽입
                let attachment = NSTextAttachment()
                attachment.image = imageResult.image
                let imageAttributedString = NSAttributedString(attachment: attachment)
                
                // 원하는 위치에 이미지 삽입
                let mutableAttributedString = NSMutableAttributedString(attributedString: textView.attributedText)
                let range = NSRange(location: location, length: 0) // 특정 위치 (예: 10번째 문자 뒤)
                mutableAttributedString.insert(imageAttributedString, at: range.location)
                textView.attributedText = mutableAttributedString
                textViewDidChange(textView)
                
            case .failure(let error):
                print("Image download failed: \(error)")
                
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let sizeToFit = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        print(sizeToFit)
        
        if sizeToFit.height > textViewDefaultHeight {
            textView.snp.updateConstraints { make in
                make.height.equalTo(sizeToFit)
            }
        }
    }
}

//MARK: - Collection View 관련
extension BoardDetailView {
    
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
    
    
    func boardDetailCellRegistration() -> BoardDetailCellRegistration  {
        
        return BoardDetailCellRegistration { cell, indexPath, itemIdentifier in
            cell.updateUI(itemIdentifier)
        }
    }
    
    func collectionViewchangeLayout(itemCount: Int) {
        
        print("🥲 CollectionView Resize")
        let oneItemSize = 115
        let size = itemCount < 1 ? 0 : oneItemSize * itemCount
        
        commentCollectionView.snp.updateConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}