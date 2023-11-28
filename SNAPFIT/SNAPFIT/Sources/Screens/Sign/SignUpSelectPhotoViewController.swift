//
//  SignUpSelectPhotoViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/28/23.
//

import UIKit
import SnapKit

final class SignUpSelectPhotoViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backNext)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "관심 있는 콘셉트의\n이미지를 선택해 주세요."
        label.numberOfLines = 2
        label.font = .b24
        label.textColor = .sfBlack100
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.allowsMultipleSelection = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCollectionView()
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
    }
    
    // MARK: Methods
    
    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(cell: SelectPhotoCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension SignUpSelectPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPhotoCollectionViewCell.className, for: indexPath) as? SelectPhotoCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setData(image: UIImage(named: "signUpPhoto\(indexPath.row)") ?? UIImage())
        
        return cell
    }
}

extension SignUpSelectPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.screenWidth - (20 * 2 + 10)) / 2, height: 160)
    }
}

// MARK: - UI

extension SignUpSelectPhotoViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, titleLabel, collectionView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
