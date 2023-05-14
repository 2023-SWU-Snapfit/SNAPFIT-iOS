//
//  ListTableView.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class ListTableViewController: UIViewController {
    private let listTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.separatorStyle = .singleLine
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension ListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") ?? ListTableViewCell()
        return cell
    }
    
    func setCellAsChattingList(cell: ListTableViewCell) {
        cell.setPicture()
        cell.setTitle(titleText: "Titles")
        cell.setSubtitle(subtitleText: "Subtitles")
        cell.setRightAsText(rightText: "yyyy.mm.dd")
    }
    
    func setCellAsHeartList(cell: ListTableViewCell) {
        cell.setPicture()
        cell.setTitle(titleText: "HeartTitle")
        cell.setSubtitle(subtitleText: "Subtitles")
        cell.setRightAsHeartButton()
    }
    
}


// MARK: - Sample Data for ListTableView
let listTableData = [
    ["Test1 Title", "Test1 Subtitle", "time1"],
    ["Test2 Title", "Test2 Subtitle", "time2"],
    ["Test3 Title", "Test3 Subtitle", "time3"],
    ["Test4 Title", "Test4 Subtitle", "time4"],
    ["Test5 Title", "Test5 Subtitle", "time5"],
]
