//
//  FavoriteListViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class FavoriteListViewController: BaseViewController {
    
    private var likeList: [LikeListResponseDTOElement] = []
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
        self.setNavigationTitle()
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        LikeService.shared.getLikeList { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? LikeListResponseDTO {
                    self.likeList = result
                    self.favoriteListTableView.reloadData()
                    print(result)
                }
            case .requestErr(_):
                print("requestError")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkErr")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Method
    private func setNavigationTitle() {
        self.navigationItem.title = "관심 목록"
        self.navigationItem.largeTitleDisplayMode = .always
        let attributes = [NSAttributedString.Key.font: UIFont.b24]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : UIFont]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setTableView() {
        self.favoriteListTableView.delegate = self
        self.favoriteListTableView.dataSource = self
        view.addSubview(favoriteListTableView)
        favoriteListTableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
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
        let currentUserID = likeList[indexPath.row].targetID
        // TODO: [PROFILE] 프로필 포지션 알게 되면 포지션 따라서로 변경
        if currentUserID % 2 == 0 {
            lazy var profileViewController: ProfilePhotographerViewController = ProfilePhotographerViewController()
            profileViewController.modalPresentationStyle = .fullScreen
            profileViewController.setUserInformation(targetID: 24)
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            lazy var profileViewController: ProfileGeneralUserViewController = ProfileGeneralUserViewController()
            profileViewController.modalPresentationStyle = .fullScreen
            profileViewController.setUserInformation(targetID: 11)
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteListTableViewCell") as! BorderedTableViewCell
        cell.setAsFavoriteList(userImageUrl: likeList[indexPath.row].profileImageUrl, userName: likeList[indexPath.row].nickname)
        return cell
    }
}
