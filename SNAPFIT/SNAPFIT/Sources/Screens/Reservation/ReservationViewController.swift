//
//  ReservationViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/19.
//

import UIKit

final class ReservationViewController: BaseViewController {
    // MARK: - Properties
    var dataDelegate: ReservationDataDelegate?
    var isFixedTab: Bool = true
    
    // FIXME: [DATABASE] DB 도입 시 cellForRowAt 정리
    var fixedReservation: ReservationListResponseDTO = []
    var notFixedReservation: ReservationListResponseDTO = []
    
    // MARK: - UIComponents
    let fixedTabButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        button.titleLabel?.textColor = .sfWhite
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: "예약 확정", attributes: attributes), for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 8)
        return button
    }()
    let notFixedTabButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        button.titleLabel?.textColor = .sfWhite
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: "문의 중", attributes: attributes), for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 8)
        return button
    }()
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
        self.setTableData()
        self.reservationTableView.reloadData()
        self.setNavigationTitle()
        self.setTabStateButtons()
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
    
    private func reviewDetail() {
        self.navigationController?.pushViewController(ReviewEditViewController(), animated: true)
    }
    
    private func setNavigationTitle() {
        self.navigationItem.title = "예약관리"
        self.navigationItem.largeTitleDisplayMode = .always
        let attributes = [NSAttributedString.Key.font: UIFont.b24]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : UIFont]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setTabStateButtons() {
        self.setTabStateButtonStyle()
        self.setTabButtonAction()
        
        self.view.addSubview(self.fixedTabButton)
        self.fixedTabButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(32)
        }
        self.view.addSubview(self.notFixedTabButton)
        self.notFixedTabButton.snp.makeConstraints { make in
            make.top.equalTo(self.fixedTabButton)
            make.leading.equalTo(self.fixedTabButton.snp.trailing).offset(16)
            make.height.equalTo(32)
        }
    }
    
    private func setTabStateButtonStyle() {
        self.fixedTabButton.setTitle("예약 확정", for: .normal)
        self.notFixedTabButton.setTitle("문의 중", for: .normal)
        if self.isFixedTab {
            self.fixedTabButton.configuration = .filled()
            self.notFixedTabButton.configuration = .tinted()
        } else {
            self.fixedTabButton.configuration = .tinted()
            self.notFixedTabButton.configuration = .filled()
        }
    }
    
    func setTabButtonAction() {
        self.fixedTabButton.setAction {
            if self.isFixedTab { return }
            self.isFixedTab.toggle()
            print(self.isFixedTab)
            self.setTableData()
            self.setTabStateButtonStyle()
            self.reservationTableView.reloadData()
        }
        
        self.notFixedTabButton.setAction {
            if !self.isFixedTab { return }
            self.isFixedTab.toggle()
            self.setTableData()
            print(self.isFixedTab)
            self.setTabStateButtonStyle()
            self.reservationTableView.reloadData()
        }
    }
    
    private func setTableData() {
        ReservationService.shared.getReservationList(
            self.isFixedTab ? .fixed : .proceeding,
            startTime: Date(timeIntervalSinceNow: -99999999),
            endTime: Date(timeIntervalSinceNow: 999999999)) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? ReservationListResponseDTO {
                    self.fixedReservation = result.filter({ $0.isConfirmed == true })
                    self.notFixedReservation = result.filter({ $0.isConfirmed == false })
                }
                self.reservationTableView.reloadData()
            default:
                print("ERRR")
            }
        }
    }
    
    private func setTableView() {
        self.reservationTableView.delegate = self
        self.reservationTableView.dataSource = self
        self.view.addSubview(reservationTableView)
        self.reservationTableView.snp.makeConstraints{ make in
            make.top.equalTo(self.fixedTabButton.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func toReservationDate(_ targetString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssssZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: targetString) {
            return date
        } else {
            return nil
        }
    }
    
    func toReservationString(_ targetDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: targetDate)
    }
}

// MARK: - Extensions
extension ReservationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lazy var detailViewController: ReservationDetailViewController = ReservationDetailViewController()
        detailViewController.reservationID = self.isFixedTab ? fixedReservation[indexPath.row].id : self.notFixedReservation[indexPath.row].id
        detailViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(detailViewController, animated: true)
    }
}

extension ReservationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFixedTab ? self.fixedReservation.count : self.notFixedReservation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTableViewCell") as! ReservationTableViewCell
        cell.rightButton.setAction {
            self.reviewDetail()
        }
        if self.isFixedTab {
            let nickname = fixedReservation[indexPath.row].senderId == UserInfo.shared.userID ? fixedReservation[indexPath.row].receiverNickname : fixedReservation[indexPath.row].senderNickname
            cell.setAsReservationList(
                userName: "\(nickname)",
                lastDate: toReservationDate(fixedReservation[indexPath.row].dateTime) ?? Date(),
                isFixed: fixedReservation[indexPath.row].isConfirmed,
                isFinished: fixedReservation[indexPath.row].isOpenUrl
            )
            cell.setPastReservation()
        } else {
            let nickname = notFixedReservation[indexPath.row].senderId == UserInfo.shared.userID ? notFixedReservation[indexPath.row].receiverNickname : notFixedReservation[indexPath.row].senderNickname
            cell.setAsReservationList(
                userName: "\(nickname)",
                lastDate: toReservationDate(notFixedReservation[indexPath.row].dateTime) ?? Date(),
                isFixed: notFixedReservation[indexPath.row].isConfirmed,
                isFinished: notFixedReservation[indexPath.row].isOpenUrl
            )
        }
        return cell
    }
}

