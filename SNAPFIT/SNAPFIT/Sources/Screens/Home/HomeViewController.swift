//
//  ViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/02.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
    
    enum TableRow: Int, CaseIterable {
        case navigation
        case reservationDetail
        case searchBar
        case categoryTag
        case photoBySelectedCategory
        case photoByPersonalCategory
        case bestPhotographerList
        case photoByTheme
    }
    
    // MARK: Components
    
    private let homeTableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let addImageButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "btn_addGallery")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    // MARK: Properties
    
    private var isReserved: Bool = false
    private var currentTagIndex: Int = 0
    private var topUsers: [GetTopUsersResponseDTO] = []
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setTableView()
        self.setAddGalleryButtonAction()
        self.getMainPhoto { photoData in
            MainPhoto.shared.data = photoData
            self.getTopUsers { users in
                self.topUsers = users
                self.homeTableView.reloadRows(at: [IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0), .init(row: TableRow.bestPhotographerList.rawValue, section: 0)], with: .automatic)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Methods
    
    private func setAddGalleryButtonAction() {
        self.addImageButton.setAction { [weak self] in
            let uploadImageViewController: BaseViewController = BaseViewController()
            self?.navigationController?.pushViewController(uploadImageViewController, animated: true)
        }
    }
}

// MARK: - Network

extension HomeViewController {
    private func getMainPhoto(completion: @escaping (GetMainTagPhotoResponseDTO) -> ()) {
        PhotoService.shared.getMainPhoto { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? GetMainTagPhotoResponseDTO {
                    completion(result)
                }
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
    
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
    
    private func getTopUsers(completion: @escaping ([GetTopUsersResponseDTO]) -> ()) {
        UserService.shared.getTopUsers { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? [GetTopUsersResponseDTO] {
                    completion(result)
                } else {
                    debugPrint("에러네,,", responseData)
                }
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
}

// MARK: - SendUpdateDelegate

extension HomeViewController: SendUpdateDelegate {
    func sendUpdate(data: Any?) {
        lazy var profileViewController: ProfilePhotographerViewController = ProfilePhotographerViewController()
        profileViewController.modalPresentationStyle = .fullScreen
        var selectedUser = self.topUsers[data as? Int ?? 0]
        profileViewController.setUserInformation(targetID: selectedUser.id)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension HomeViewController: SendImageDelegate {
    func sendUpdate(image: UIImage) {
        lazy var vc: PhotoViewController = PhotoViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.setData(image: image)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: PhotoByTagUpdateDelegate {
    func sendUpdate(tag: Int) {
        self.currentTagIndex = tag
        self.homeTableView.reloadRows(at: [IndexPath(row: TableRow.photoBySelectedCategory.rawValue, section: 0)], with: .automatic)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let rowType = TableRow(rawValue: indexPath.row) {
            switch rowType {
            case .navigation:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeNavigationTableViewCell.className) as? HomeNavigationTableViewCell
                else { return UITableViewCell() }
                
                cell.navigationView.notificationButton.removeTarget(nil, action: nil, for: .allEvents)
                cell.navigationView.notificationButton.setAction { [weak self] in
                    self?.navigationController?.pushViewController(NotificationViewController(), animated: true)
                }
                
                return cell
            case .reservationDetail:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeReservationDetailTableViewCell.className) as? HomeReservationDetailTableViewCell
                else { return UITableViewCell() }
                
                return cell
            case .searchBar:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeSearchBarTableViewCell.className) as? HomeSearchBarTableViewCell
                else { return UITableViewCell() }
                cell.searchButton.removeTarget(nil, action: nil, for: .allTouchEvents)
                cell.searchButton.setAction { [weak self] in
                    let searchViewController: SearchViewController = SearchViewController()
                    self?.navigationController?.pushViewController(searchViewController, animated: true)
                }
                return cell
            case .categoryTag:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCategoryTagTableViewCell.className) as? HomeCategoryTagTableViewCell
                else { return UITableViewCell() }
                cell.delegate = self
                return cell
            case .photoBySelectedCategory:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePhotoByCategoryTableViewCell.className) as? HomePhotoByCategoryTableViewCell
                else { return UITableViewCell() }
                cell.sendImageDelegate = self
                cell.currentTagIndex = self.currentTagIndex
                cell.collectionView.reloadData()
                return cell
            case .photoByPersonalCategory:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePhotoByPersonalCetegoryTableViewCell.className) as? HomePhotoByPersonalCetegoryTableViewCell
                else { return UITableViewCell() }
                cell.setTitle(titleTag: "\(UserInfo.shared.nickname) 님을 위한 추천")
                cell.sendImageDelegate = self
                cell.collectionView.reloadData()
                return cell
            case .bestPhotographerList:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotographerListTableViewCell.className) as? PhotographerListTableViewCell
                else { return UITableViewCell() }
                cell.setTitle(titleTag: "인기 작가")
                cell.setData(data: self.topUsers)
                cell.sendUpdateDelegate = self
                return cell
            case .photoByTheme:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePhotoByThemeTableViewCell.className) as? HomePhotoByThemeTableViewCell
                else { return UITableViewCell() }
                cell.setData(title: "#겨울", image: UIImage(), tagsText: "#디지털 #겨울")
                cell.photoImageView.setImageUrl(MainPhoto.shared.data.season[0].photoURL)
                return cell
            }
        } else { return UITableViewCell() }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let rowType = TableRow(rawValue: indexPath.row) {
            switch rowType {
            case .navigation:
                return 44
            case .reservationDetail:
                return self.isReserved ? 128 : 0
            case .searchBar:
                return 64
            case .categoryTag:
                return 48
            case .photoBySelectedCategory:
                return 312
            case .photoByPersonalCategory:
                return 255
            case .bestPhotographerList:
                return 187
            case .photoByTheme:
                return 309
            }
        } else { return 0 }
    }
}

// MARK: - UI

extension HomeViewController {
    
    private func setTableView() {
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
        self.homeTableView.register(cell: HomeNavigationTableViewCell.self)
        self.homeTableView.register(cell: HomeReservationDetailTableViewCell.self)
        self.homeTableView.register(cell: HomeSearchBarTableViewCell.self)
        self.homeTableView.register(cell: HomeCategoryTagTableViewCell.self)
        self.homeTableView.register(cell: HomePhotoByCategoryTableViewCell.self)
        self.homeTableView.register(cell: HomePhotoByPersonalCetegoryTableViewCell.self)
        self.homeTableView.register(cell: PhotographerListTableViewCell.self)
        self.homeTableView.register(cell: HomePhotoByThemeTableViewCell.self)
    }
    
    private func setLayout() {
        self.view.addSubviews([homeTableView, addImageButton])
        
        self.homeTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.bottom.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
    }
}
