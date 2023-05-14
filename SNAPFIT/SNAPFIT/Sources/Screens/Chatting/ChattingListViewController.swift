//
//  ChattingListViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class ChattingListViewController: UIViewController {
    private let chattingListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chattingListTableView.separatorStyle = .singleLine
        chattingListTableView.delegate = self
        chattingListTableView.dataSource = self
        chattingListTableView.register(ChattingListTableViewCell.self, forCellReuseIdentifier: "chattingListTableViewCell")
        view.addSubview(chattingListTableView)
        chattingListTableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension ChattingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        86
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 셀 선택 시 동작 구현
    }
}

extension ChattingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chattingListTableViewCell") as! ChattingListTableViewCell
        cell.setPicture()
        cell.setTitle(titleText: "Titles")
        cell.setSubtitle(subtitleText: "Subtitles")
        cell.setRighttitle(rightText: "yyyy.mm.dd")
        return cell
    }
}
