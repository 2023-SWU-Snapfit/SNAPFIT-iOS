//
//  HomePhotoByPersonalCetegoryTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/06/03.
//

import UIKit
import SnapKit

final class HomePhotoByPersonalCetegoryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = .b18
        titleLabel.textColor = .sfBlack100
        return titleLabel
    }()
    
    private let collectionView: UICollectionView = {
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
        
        self.collectionView.register(cell: HorizontalPhotoCollectionViewCell.self)
    }
    
    func setTitle(titleTag: String) {
        self.titleLabel.text = "#" + titleTag
    }
}

// MARK: -

extension HomePhotoByPersonalCetegoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalPhotoCollectionViewCell.className, for: indexPath) as? HorizontalPhotoCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setData(image: UIImage(named: "sampleImage\(Tag.shared.category.shuffled()[indexPath.row].id)") ?? UIImage(), username: users.shuffled()[indexPath.row].userName)
        
        return cell
    }
}

extension HomePhotoByPersonalCetegoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 208, height: 202)
    }
}

// MARK: - UI

extension HomePhotoByPersonalCetegoryTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.contentView.addSubviews([titleLabel, collectionView])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
