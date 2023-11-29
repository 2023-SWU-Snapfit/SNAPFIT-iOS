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
        self.setNextButtonAction()
    }
    
    // MARK: Methods
    
    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(cell: SelectPhotoCollectionViewCell.self)
    }
    
    private func interestTags() -> [Int] {
        var index: [Int] = []
        var tags: [Int] = []
        
        self.collectionView.indexPathsForSelectedItems?.forEach({
            index.append($0.row)
        })
        
        index.forEach { i in
            switch i {
            case 0:
                tags.append(contentsOf: [7, 2, 4, 27])
            case 1:
                tags.append(contentsOf: [8, 9, 2, 3])
            case 2:
                tags.append(contentsOf: [10, 9, 2, 4])
            case 3:
                tags.append(contentsOf: [11, 9, 2, 3])
            case 4:
                tags.append(contentsOf: [12, 9, 2, 5])
            case 5:
                tags.append(contentsOf: [13, 9, 2, 5])
            case 6:
                tags.append(contentsOf: [14, 9, 2, 4])
            case 7:
                tags.append(contentsOf: [15, 9, 2, 3])
            case 8:
                tags.append(contentsOf: [16, 9, 2, 3])
            case 9:
                tags.append(contentsOf: [17, 9, 2, 4])
            case 10:
                tags.append(contentsOf: [18, 9, 2, 4])
            case 11:
                tags.append(contentsOf: [19, 9, 1, 3])
            default:
                tags.append(2)
            }
        }
        tags = Array(Set(tags))
        
        return tags
    }
    
    private func setNextButtonAction() {
        self.navigationView.nextButton.setAction { [weak self] in
            SignUpRequestData.shared.interest = self?.interestTags() ?? []
            self?.requestSignUp(data: SignUpRequestData.shared.dtoData())
        }
    }
}

// MARK: - Network

extension SignUpSelectPhotoViewController {
    private func requestSignUp(data: SignUpRequestDTO) {
        self.startActivityIndicator()
        SignService.shared.requestSignUp(data: data) { networkResult in
            switch networkResult {
            case .success:
                self.makeAlert(title: "📸", message: "회원가입이 완료되었습니다.", okTitle: "로그인하러 가기", okAction: { _ in 
                    self.dismiss(animated: true)
                })
            default:
                self.showNetworkErrorAlert()
            }
            self.stopActivityIndicator()
        }
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
