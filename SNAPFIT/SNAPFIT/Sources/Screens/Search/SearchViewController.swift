//
//  SearchViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    // MARK: Properties
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backSearch)
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCollectionView()
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setSearhButtonAction()
    }
    
    // MARK: Methods
    
    private func setSearhButtonAction() {
        self.navigationView.searchTextField.delegate = self

    }
    
    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(cell: CategoryPhotoCollectionViewCell.self)
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let vc = SearchInputViewController()
        vc.keyword = textField.text ?? ""
        vc.isSearchByKeyword = true
        
        self.navigationController?.pushViewController(vc, animated: true)
//        self.searchResults = SearchResult(
//            photos: [],
//            users: [
//            ]
//        )
//        
//        self.tableView.reloadData()
        return true
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tag.shared.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryPhotoCollectionViewCell.className, for: indexPath) as? CategoryPhotoCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setData(image: UIImage(named: "sampleImage\(Tag.shared.category[indexPath.row].id)") ?? UIImage(), title: Tag.shared.category[indexPath.row].name)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchResultViewController: SearchInputViewController = SearchInputViewController()
        searchResultViewController.setSearchByCategoryTag(selectedTagIndex: indexPath.row)
        self.navigationController?.pushViewController(searchResultViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (self.screenWidth - 20 * 2 - 16 * 3) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

// MARK: - UI

extension SearchViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, collectionView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
