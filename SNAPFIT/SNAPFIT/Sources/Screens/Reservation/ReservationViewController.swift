//
//  ReservationViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/19.
//

import UIKit

final class ReservationViewController: BaseViewController {
    let reservationTableView = UITableView()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
    }
    
    private func setLayout() {
        self.view.backgroundColor = .sfGrayWhite
        self.reservationTableView.backgroundColor = .clear
        self.reservationTableView.separatorStyle = .none
        self.reservationTableView.showsVerticalScrollIndicator = false
        self.reservationTableView.delegate = self
        self.reservationTableView.dataSource = self
        self.reservationTableView.register(BorderedTableViewCell.self, forCellReuseIdentifier: "reservationTableViewCell")
        view.addSubview(reservationTableView)
        reservationTableView.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Extensions
extension ReservationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        82
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 셀 선택 시 동작 구현
    }
}

extension ReservationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTableViewCell") as! BorderedTableViewCell
        cell.setPicture()
        cell.setTitle(titleText: "여기도닉네임이\(indexPath.row)")
        return cell
    }
}
