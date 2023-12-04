//
//  PhotographerTableViewCell.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/06/07.
//

import UIKit
import SnapKit

final class PhotographerListTableViewCell: UITableViewCell {
    
    // MARK: UIComponents
    
    private let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = .b18
        titleLabel.textColor = .sfBlack100
        return titleLabel
    }()
    
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
    
    // MARK: Properties
    
    var userList: [GetTopUsersResponseDTO] = []
    var sendUpdateDelegate: SendUpdateDelegate?
    
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
        
        self.collectionView.register(cell: PhotographerCollectionViewCell.self)
    }
    
    func setTitle(titleTag: String) {
        self.titleLabel.text = titleTag
    }
    
    func setData(data: [GetTopUsersResponseDTO]) {
        self.userList = data
        debugPrint("topUsers", data)
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension PhotographerListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotographerCollectionViewCell.className, for: indexPath) as? PhotographerCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setData(profileImage: UIImage(), username: self.userList[indexPath.row].nickname)
        cell.imageView.setImageUrl(self.userList[indexPath.row].profileImageURL ?? "")
//        cell.setData(profileImage: UIImage(named: "sampleImage\(Tag.shared.category.shuffled()[indexPath.row].id)") ?? UIImage(), username: users.shuffled()[indexPath.row].userName)
        
        return cell
    }
}

// MARK: -

extension PhotographerListTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.sendUpdateDelegate?.sendUpdate(data: indexPath.row)
    }
}

extension PhotographerListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 134)
    }
}

// MARK: - UI

extension PhotographerListTableViewCell {
    
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
