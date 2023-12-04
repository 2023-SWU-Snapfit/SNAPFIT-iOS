//
//  SearchInputViewController.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/06/12.
//

import UIKit
import SnapKit

enum SearchType: Int, CaseIterable {
    case photo
    case user
}

final class SearchInputViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backSearch)
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: Properties
    
    private var searchResults: SearchResult = SearchResult(photos: [], users: [])
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTableView()
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setSearchTextField()
    }
    
    // MARK: Methods
    
    private func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(SearchResultTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchResultTableViewHeaderView.className)
        self.tableView.register(cell: PhotoSearchResultTableViewCell.self)
        self.tableView.register(cell: PhotographerListTableViewCell.self)
    }
    
    private func setSearchTextField() {
        self.navigationView.searchTextField.delegate = self
    }
    
    func setSearchByCategoryTag(selectedTagIndex: Int) {
        self.getPhotoByTag(tags: [selectedTagIndex + 7]) { photoList in
            self.searchResults = SearchResult(photos: [], users: [])
            _ = photoList.map { photo in
                var photoImage = UIImage()
                photo.photoURL.getImage { image in
                    photoImage = image
                }
                self.searchResults.photos.append(SearchResult.PhotoSearchResult(image: photoImage, tagsText: photo.tag.getTagText(), username: photo.nickname))
            }
            self.searchResults.users = [
                SummaryUser(userId: 1, image: users[2].profileImage ?? UIImage(), username: users[2].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[3].id)") ?? UIImage(), username: users[3].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[4].id)") ?? UIImage(), username: users[4].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[5].id)") ?? UIImage(), username: users[5].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[6].id)") ?? UIImage(), username: users[6].userName, isPhotographer: true)
            ]
            
            self.tableView.reloadData()
        }
//        _ = self.textFieldShouldReturn(self.navigationView.searchTextField)
    }
}

// MARK: - UITextFieldDelegate

extension SearchInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.searchResults = SearchResult(
            photos: [
                SearchResult.PhotoSearchResult(image: UIImage(named: "sampleImage\(Tag.shared.category[0].id)") ?? UIImage(), tagsText: "#\(Tag.shared.mood[0].name) #\(Tag.shared.mood[4].name)", username: users[0].userName),
                SearchResult.PhotoSearchResult(image: UIImage(named: "sampleImage\(Tag.shared.category[1].id)") ?? UIImage(), tagsText: "#\(Tag.shared.mood[1].name)", username: users[1].userName),
                SearchResult.PhotoSearchResult(image: UIImage(named: "sampleImage\(Tag.shared.category[9].id)") ?? UIImage(), tagsText: "#\(Tag.shared.mood[9].name)", username: users[9].userName)
            ],
            users: [
                SummaryUser(userId: 1, image: users[2].profileImage ?? UIImage(), username: users[2].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[3].id)") ?? UIImage(), username: users[3].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[4].id)") ?? UIImage(), username: users[4].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[5].id)") ?? UIImage(), username: users[5].userName, isPhotographer: true),
                SummaryUser(userId: 1, image: UIImage(named: "sampleImage\(Tag.shared.category[6].id)") ?? UIImage(), username: users[6].userName, isPhotographer: true)
            ]
        )
        
        self.tableView.reloadData()
        return true
    }
}

// MARK: - Network

extension SearchInputViewController {
    private func getPhotoByTag(tags: [Int], completion: @escaping ([GetPhotoByTagResponseDTO.Photo]) -> ()) {
        PhotoService.shared.getPhotoByTag(tags: tags) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? GetPhotoByTagResponseDTO {
                    completion(result.photoData)
                }
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
}

// MARK: - SendUpdateDelegate

extension SearchInputViewController: SendUpdateDelegate {
    func sendUpdate(data: Any?) {
        lazy var profileViewController: ProfilePhotographerViewController = ProfilePhotographerViewController()
        profileViewController.modalPresentationStyle = .fullScreen
        profileViewController.setUserInformation(currentUser: users[2])
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SearchInputViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SearchType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowType = SearchType(rawValue: section) {
            switch rowType {
            case .photo: return searchResults.photos.count
            case .user: return 1
            }
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let rowType = SearchType(rawValue: section) {
            switch rowType {
            case .photo:
                guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchResultTableViewHeaderView.className) as? SearchResultTableViewHeaderView
                else { return UIView() }
                
                headerView.setLayout(searchType: rowType)
                return headerView
            case .user:
                return UIView()
            }

        } else { return UIView() }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let rowType = SearchType(rawValue: indexPath.section) {
            switch rowType {
            case .photo:
                let cell = tableView.dequeueReusableCell(withType: PhotoSearchResultTableViewCell.self, for: indexPath)
                
                cell.setData(data: self.searchResults.photos[indexPath.row])
                
                return cell
            case .user:
                let cell = tableView.dequeueReusableCell(withType: PhotographerListTableViewCell.self, for: indexPath)
                
                cell.setTitle(titleTag: "유저 검색 결과")
                cell.setData(data: TopUsers.shared.data)
                cell.sendUpdateDelegate = self
                return cell
            }
        } else { return UITableViewCell() }
    }
}

// MARK: - UITableViewDelegate

extension SearchInputViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let rowType = SearchType(rawValue: indexPath.section) {
            switch rowType {
            case .photo: return 100
            case .user: return 206
            }
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lazy var vc: PhotoViewController = PhotoViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.setData(image: self.searchResults.photos[indexPath.row].image)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UI

extension SearchInputViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, tableView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
