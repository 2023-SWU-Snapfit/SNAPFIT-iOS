//
//  HomePhotoByCategoryTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/06/03.
//

import UIKit
import SnapKit

final class HomePhotoByCategoryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    let collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    var sendImageDelegate: SendImageDelegate?
    var categoryData = Tag.shared.category.shuffled()
    var currentTagIndex: Int = 0
    
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
        
        self.collectionView.register(cell: VerticalPhotoCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension HomePhotoByCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint(self.currentTagIndex)
        return MainPhoto.shared.data.tagPhoto[self.currentTagIndex].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalPhotoCollectionViewCell.className, for: indexPath) as? VerticalPhotoCollectionViewCell
        else { return UICollectionViewCell() }
        debugPrint("MAINPHOTO", MainPhoto.shared.data.tagPhoto[self.currentTagIndex].photos)
        DispatchQueue.main.async {
            cell.setData(image: UIImage(), username: MainPhoto.shared.data.tagPhoto[self.currentTagIndex].photos[indexPath.row].nickname)
            cell.imageView.setImageUrl(MainPhoto.shared.data.tagPhoto[self.currentTagIndex].photos[indexPath.row].photoURL)
        }

        
        return cell
    }
}

extension HomePhotoByCategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? VerticalPhotoCollectionViewCell {
            self.sendImageDelegate?.sendUpdate(image: cell.imageView.image ?? UIImage())
        }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomePhotoByCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 208, height: 296)
    }
}

// MARK: - UI

extension HomePhotoByCategoryTableViewCell {
    
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
