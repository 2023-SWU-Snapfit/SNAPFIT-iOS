//
//  HomeCategoryTagTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/25.
//

import UIKit

final class HomeCategoryTagTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private let collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    var delegate: PhotoByTagUpdateDelegate?
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCollectionView()
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(cell: TagCollectionViewCell.self)
        
        self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeCategoryTagTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainPhoto.shared.data.tagPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setData(title: MainPhoto.shared.data.tagPhoto[indexPath.row].tagName)
        
        return cell
    } 
}

// MARK: - UICollectionViewDelegate

extension HomeCategoryTagTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("실행됨")
        self.delegate?.sendUpdate(tag: indexPath.row)
    }
}

extension HomeCategoryTagTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizingCell = TagCollectionViewCell()
        sizingCell.setData(title: MainPhoto.shared.data.tagPhoto[indexPath.row].tagName)
        
        let cellWidth = sizingCell.titleLabel.frame.width + 32
        let cellHeight = 32
        return CGSize(width: cellWidth, height: CGFloat(cellHeight))
    }
}

// MARK: - UI

extension HomeCategoryTagTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([collectionView])
        
        self.collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
}
