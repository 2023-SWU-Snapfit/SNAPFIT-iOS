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
        case personalCategoryTitle
        case photoByPersonalCategory
        case bestPhotographerTitle
        case bestPhotographerList
        case themeTitle
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setTableView()
    }

}

// MARK: - UI

extension HomeViewController {
    
    private func setTableView() {
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
        self.homeTableView.register(cell: HomeNavigationTableViewCell.self)
    }
    
    private func setLayout() {
        self.view.addSubviews([homeTableView])
        
        self.homeTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let rowType = TableRow(rawValue: indexPath.row) {
            switch rowType {
            case .navigation:
                return 44
            default:
                return 100
            }
        } else { return 0 }
    }
}
