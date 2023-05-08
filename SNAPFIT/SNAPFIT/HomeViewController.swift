//
//  ViewController.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/02.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sampleLabel = UILabel()
        sampleLabel.text = "View Sample"
        sampleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sampleLabel)
        NSLayoutConstraint.activate([
            sampleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            sampleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }


}

