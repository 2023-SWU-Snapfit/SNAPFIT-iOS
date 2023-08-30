//
//  ContactTableViewCell.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/08/30.
//

import UIKit

class SettingContactTableViewCell: UITableViewCell {
    
    enum Text {
        static let title = "연락처 URL*"
        static let placeholder = "오픈채팅, 인스타그램 등 소통 가능한 URL을 적어주세요."
        static let information = "원활한 문의를 위해 연락 가능한 URL, 메신저 ID 등을 꼭 남겨 주세요."
        static let saveTitle = "저장하기"
    }
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .r14
        label.textColor = .sfBlack100
        label.text = Text.title
        return label
    }()
    private let textView: SnapfitTextView = {
        let textview: SnapfitTextView = SnapfitTextView(isEditable: true)
        textview.setPlaceholder(text: Text.placeholder)
        textview.setEditableStyle()
        textview.isScrollEnabled = false
        return textview
    }()
    private let informationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .m12
        label.textColor = .sfBlack60
        label.text = Text.information
        label.numberOfLines = 2
        return label
    }()
    private let saveButton: UIButton = {
        let button: UIButton = UIButton()
        button.configuration = .filled()
        let attributes = [NSAttributedString.Key.font : UIFont.b14]
        button.setAttributedTitle(NSAttributedString(string: Text.saveTitle, attributes: attributes), for: .normal)
        button.titleLabel?.textColor = .sfWhite
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        button.tintColor = .sfBlack100
        button.makeRounded(cornerRadius: 10)
        return button
    }()

    func setLayout() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        self.contentView.addSubview(self.textView)
        self.textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        self.contentView.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(24)
        }
        self.contentView.addSubview(self.informationLabel)
        self.informationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.saveButton)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalTo(self.saveButton.snp.leading).offset(-10)
        }
    }
    
    func setText(newText: String) {
        self.textView.text = newText
    }
    
    func getText() -> String {
        return self.textView.text
    }
}
