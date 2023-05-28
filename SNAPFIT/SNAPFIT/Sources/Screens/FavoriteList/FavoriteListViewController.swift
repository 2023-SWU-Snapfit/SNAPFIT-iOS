//
//  FavoriteListViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class FavoriteListViewController: BaseViewController {
    let favoriteListTableView = UITableView()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
    }
    
    private func setLayout() {
        self.view.backgroundColor = .sfGrayWhite
        self.favoriteListTableView.backgroundColor = .clear
        self.favoriteListTableView.separatorStyle = .none
        self.favoriteListTableView.showsVerticalScrollIndicator = false
        self.favoriteListTableView.delegate = self
        self.favoriteListTableView.dataSource = self
        self.favoriteListTableView.register(BorderedTableViewCell.self, forCellReuseIdentifier: "favoriteListTableViewCell")
        view.addSubview(favoriteListTableView)
        favoriteListTableView.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
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
        // TODO: 셀 선택 시 동작 구현
    }
}

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteListTableViewCell") as! BorderedTableViewCell
        cell.setPicture()
        cell.setTitle(titleText: "닉네임열글자까지\(indexPath.row)")
        return cell
    }
}
