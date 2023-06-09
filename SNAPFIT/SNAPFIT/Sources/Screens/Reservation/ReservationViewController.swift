//
//  ReservationViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/19.
//

import UIKit

final class ReservationViewController: BaseViewController {
    
    // MARK: - UIComponents
    let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "예약 관리"
        titleLabel.font = .b24
        return titleLabel
    }()
    let reservationTableView: UITableView = {
        let reservationTableView: UITableView = UITableView()
            reservationTableView.backgroundColor = .clear
            reservationTableView.separatorStyle = .none
            reservationTableView.showsVerticalScrollIndicator = false
            reservationTableView.register(BorderedTableViewCell.self, forCellReuseIdentifier: "reservationTableViewCell")
        return reservationTableView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLayout()
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.reservationTableView.reloadData()
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
        self.reservationTableView.delegate = self
        self.reservationTableView.dataSource = self
        self.view.addSubview(reservationTableView)
        self.reservationTableView.snp.makeConstraints{ make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
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
        lazy var detailViewController: ReservationDetailViewController = ReservationDetailViewController()
        detailViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ReservationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTableViewCell") as! BorderedTableViewCell
        cell.setPicture(reservations[indexPath.row].profileImage)
        cell.setTitle(titleText: reservations[indexPath.row].userName)
        return cell
    }
}
