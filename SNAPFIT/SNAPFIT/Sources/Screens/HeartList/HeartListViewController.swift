//
//  HeartListViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class HeartListViewController: UIViewController {
    let heartListTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartListTableView.separatorStyle = .singleLine
        heartListTableView.delegate = self
        heartListTableView.dataSource = self
        heartListTableView.register(HeartListTableViewCell.self, forCellReuseIdentifier: "heartListTableViewCell")
        view.addSubview(heartListTableView)
        heartListTableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension HeartListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        82
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 셀 선택 시 동작 구현
    }
}

extension HeartListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heartListTableViewCell") as! HeartListTableViewCell
        cell.setPicture()
        cell.setTitle(titleText: "닉네임\(indexPath.row)")
        cell.setRightButton()
        return cell
    }
}
