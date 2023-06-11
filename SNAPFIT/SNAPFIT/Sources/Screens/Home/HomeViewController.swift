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
    
    // MARK: Properties
    
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
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setTableView()
        self.setAddGalleryButtonAction()
    }
    
    // MARK: Methods
    
    private func setAddGalleryButtonAction() {
        self.addImageButton.setAction { [weak self] in
            let uploadImageViewController: BaseViewController = BaseViewController()
            self?.navigationController?.pushViewController(uploadImageViewController, animated: true)
        }
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
                
                return cell
            case .categoryTag:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCategoryTagTableViewCell.className) as? HomeCategoryTagTableViewCell
                else { return UITableViewCell() }
                
                return cell
            case .photoBySelectedCategory:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePhotoByCategoryTableViewCell.className) as? HomePhotoByCategoryTableViewCell
                else { return UITableViewCell() }
                
                return cell
            case .photoByPersonalCategory:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePhotoByPersonalCetegoryTableViewCell.className) as? HomePhotoByPersonalCetegoryTableViewCell
                else { return UITableViewCell() }
                cell.setTitle(titleTag: "일상")
                return cell
            case .bestPhotographerList:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotographerListTableViewCell.className) as? PhotographerListTableViewCell
                else { return UITableViewCell() }
                cell.setTitle(titleTag: "인기 작가")
                return cell
            case .photoByTheme:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePhotoByThemeTableViewCell.className) as? HomePhotoByThemeTableViewCell
                else { return UITableViewCell() }
                cell.setData(title: "6월 추천", image: UIImage(named: "sampleImage2") ?? UIImage(), tagsText: "#반려동물 #화사한 #여름")
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
                return 128
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
