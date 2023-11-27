//
//  SettingViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/08/29.
//

import UIKit

class SettingViewController: BaseViewController {
    
    enum Text {
        static let navigationTitle = "설정"
        static let pushTitle = "푸시알림 설정"
        static let dataRuleTitle = "개인정보처리방침"
        static let generalRuleTitle = "이용약관"
        static let noticeTitle = "공지사항"
        static let logoutTitle = "로그아웃"
        static let quitTitle = "회원탈퇴"
    }
    
    // MARK: - UIComponents
    private let navigationView: SnapfitNavigationView = {
        let view: SnapfitNavigationView = SnapfitNavigationView(type: .backTitle)
        return view
    }()
    private let tableView: UITableView = UITableView()
    private let contactCell: SettingContactTableViewCell = {
        let cell: SettingContactTableViewCell = SettingContactTableViewCell()
        cell.setLayout()
        cell.setText(newText: "snapFit@google.com")
        cell.selectionStyle = .none
        return cell
    }()
    private let pushCell: UITableViewCell = {
        let cell: UITableViewCell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = Text.pushTitle
        configuration.textProperties.font = .r14
        cell.contentConfiguration = configuration
        return cell
    }()
    let toggle: UISwitch = UISwitch()
    private let dataRuleCell: UITableViewCell = {
        let cell: UITableViewCell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = Text.dataRuleTitle
        configuration.textProperties.font = .r14
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    private let generalRuleCell: UITableViewCell = {
        let cell: UITableViewCell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = Text.generalRuleTitle
        configuration.textProperties.font = .r14
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    private let noticeCell: UITableViewCell = {
        let cell: UITableViewCell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = Text.noticeTitle
        configuration.textProperties.font = .r14
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    private let memberCell: UITableViewCell = {
        let cell: UITableViewCell = UITableViewCell()
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 900, bottom: 0, right: 0)
        return cell
    }()
    private let logOutButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .plain()
        let attributes = [NSAttributedString.Key.font : UIFont.r14, NSAttributedString.Key.foregroundColor : UIColor.sfBlack100]
        button.setAttributedTitle(NSAttributedString(string: Text.logoutTitle, attributes: attributes), for: .normal)
        return button
    }()
    private let quitButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .plain()
        let attributes = [NSAttributedString.Key.font : UIFont.r14, NSAttributedString.Key.foregroundColor : UIColor.sfBlack100]
        button.setAttributedTitle(NSAttributedString(string: Text.quitTitle, attributes: attributes), for: .normal)
        return button
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setTableView()
        self.setPushCell(isOn: true)
        self.setMemberCell()
    }
    
    private func setNavigationView() {
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.left.right.equalToSuperview()
        }
        self.navigationView.backButton.setAction {
            self.dismiss(animated: true)
        }
        self.navigationView.setTitle(Text.navigationTitle)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorInset.left = 0
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setPushCell(isOn: Bool) {
        self.toggle.isOn = isOn
        self.toggle.onTintColor = .sfMainRed
        
        self.pushCell.contentView.addSubview(self.toggle)
        self.toggle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    private func setMemberCell() {
        self.memberCell.contentView.addSubview(self.quitButton)
        self.quitButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
        self.memberCell.contentView.addSubview(self.logOutButton)
        self.logOutButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.quitButton.snp.leading).offset(-12)
        }
        
        self.quitButton.setAction {
            print("quit")
        }
        
        self.logOutButton.setAction {
            print("logout")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                return self.contactCell
            case 1:
                return self.pushCell
            case 2:
                return self.dataRuleCell
            case 3:
                return self.generalRuleCell
            case 4:
                return self.noticeCell
            case 5:
                return self.memberCell
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 146
            default:
                return 54
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
