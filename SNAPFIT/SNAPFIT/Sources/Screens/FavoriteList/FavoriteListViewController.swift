//
//  FavoriteListViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class FavoriteListViewController: BaseViewController {
    let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "관심 목록"
        titleLabel.font = .b24
        return titleLabel
    }()
    let favoriteListTableView: UITableView = {
        let favoriteListTableView: UITableView = UITableView()
        favoriteListTableView.backgroundColor = .clear
        favoriteListTableView.separatorStyle = .none
        favoriteListTableView.showsVerticalScrollIndicator = false
        favoriteListTableView.register(BorderedTableViewCell.self, forCellReuseIdentifier: "favoriteListTableViewCell")
        return favoriteListTableView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLayout()
        self.setTableView()
    }
    
    // MARK: - Method
    private func setTitleLayout() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(92)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func setTableView() {
        self.favoriteListTableView.delegate = self
        self.favoriteListTableView.dataSource = self
        view.addSubview(favoriteListTableView)
        favoriteListTableView.snp.makeConstraints{ make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Extensions
extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        82
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = users[indexPath.row]
        if currentUser.isPhotographer {
            lazy var profileViewController: ProfilePhotographerViewController = ProfilePhotographerViewController()
            profileViewController.modalPresentationStyle = .fullScreen
            profileViewController.setBasicData(
                isApproved: true,
                nicknameText: currentUser.userName,
                instagramText: currentUser.instagramID
            )
            profileViewController.setAdditionalData(
                mailText: currentUser.emailAddress ?? "",
                introduceText: currentUser.introduceText ?? "",
                possibleDateText: currentUser.possibleDateText ?? "",
                priceText: currentUser.priceText ?? ""
            )
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            lazy var profileViewController: ProfileGeneralUserViewController = ProfileGeneralUserViewController()
            profileViewController.modalPresentationStyle = .fullScreen
            profileViewController.setBasicData(
                isApproved: true,
                nicknameText: currentUser.userName,
                instagramText: currentUser.instagramID
            )
            profileViewController.setAdditionalData(
                mailText: currentUser.emailAddress ?? "",
                introduceText: currentUser.introduceText ?? ""
            )
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteListTableViewCell") as! BorderedTableViewCell
        cell.setPicture(users[indexPath.row].profileImage)
        cell.setTitle(titleText: "\(users[indexPath.row].userName)")
        return cell
    }
}
