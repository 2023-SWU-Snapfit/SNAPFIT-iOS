//
//  SnapfitDatePickerViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/09.
//

import UIKit
import SnapKit

class SnapfitDatePickerViewController: BaseViewController {
    
    // MARK: - UIComponents
    let contentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .sfWhite
        view.makeRounded(cornerRadius: 13)
        return view
    }()
    let datePicker: UIDatePicker = {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.tintColor = .sfMainRed
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko_KR")
        return datePicker
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    // MARK: - Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    private func setLayout() {
        self.view.backgroundColor = .sfBlack100.withAlphaComponent(0.5)
        self.view.addSubview(contentView)
        self.contentView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(380)
        }
        self.contentView.addSubview(self.datePicker)
        self.datePicker.snp.makeConstraints{ make in
            make.centerY.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
