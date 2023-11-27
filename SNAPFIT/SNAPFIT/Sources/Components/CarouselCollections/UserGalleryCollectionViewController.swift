//
//  GalleryCarouselViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/19.
//

import UIKit
import SnapKit

class UserGalleryCollectionViewController: UIViewController {
    
    // MARK: - Properties
    private var numOfItems: Int = 0
    private var gallaryData: [Gallery] = []
    
    // MARK: - UIComponents
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "갤러리"
        label.font = .b18
        return label
    }()
    let moreButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .plain()
        let attributes = [NSAttributedString.Key.font : UIFont.m12]
        button.setAttributedTitle(NSAttributedString(string: "더보기 ", attributes: attributes), for: .normal)
        button.tintColor = .sfBlack60
        let moreButtonImage = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        button.setImage(moreButtonImage, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.itemSize = CGSize(width: 100, height: 135)
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 10, height: 10), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "galleryCell")
        self.collectionView.backgroundColor = .clear
    }
    
    // MARK: - Methods
    
    public func setGallery(gallery: [Gallery]) {
        self.numOfItems = gallery.count
        self.gallaryData = gallery
    }
    
    func setLayout() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalTo(20)
        }
        self.view.addSubview(self.moreButton)
        self.moreButton.snp.makeConstraints{ make in
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension UserGalleryCollectionViewController: UICollectionViewDelegate {
    
}

extension UserGalleryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath)
        cell.backgroundColor = .sfBlack40
        cell.makeRounded(cornerRadius: 8)
        let imageView: UIImageView = UIImageView()
        imageView.setImageUrl(self.gallaryData[indexPath.row].photoUrl)
        imageView.contentMode = .scaleAspectFill
        cell.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        return cell
    }
    
    
}

extension UserGalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
}
