//
//  ReservationViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/19.
//

import UIKit

final class ReservationViewController: BaseViewController {
    
    // MARK: - UIComponents
    let reservationTableView: UITableView = {
        let reservationTableView: UITableView = UITableView()
            reservationTableView.backgroundColor = .clear
            reservationTableView.separatorStyle = .none
            reservationTableView.showsVerticalScrollIndicator = false
            reservationTableView.register(ReservationTableViewCell.self, forCellReuseIdentifier: "reservationTableViewCell")
        return reservationTableView
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
        self.reservationTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Method
    
    private func setNavigationTitle() {
        self.navigationItem.title = "예약관리"
        self.navigationItem.largeTitleDisplayMode = .always
        let attributes = [NSAttributedString.Key.font: UIFont.b24]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : UIFont]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setTableView() {
        self.reservationTableView.delegate = self
        self.reservationTableView.dataSource = self
        self.view.addSubview(reservationTableView)
        self.reservationTableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Extensions
extension ReservationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 셀 선택 시 동작 구현
        lazy var detailViewController: ReservationDetailViewController = ReservationDetailViewController()
        detailViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(detailViewController, animated: true)
    }
}

extension ReservationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[reservationData[indexPath.row].userIndex]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTableViewCell") as! ReservationTableViewCell
        cell.setAsReservationList(
            userName: "\(user.userName)",
            lastDate: reservationData[indexPath.row].lastUpdate,
            isFixed: reservationData[indexPath.row].isFixed,
            isFinished: reservationData[indexPath.row].isFinished
        )
        return cell
    }
}
