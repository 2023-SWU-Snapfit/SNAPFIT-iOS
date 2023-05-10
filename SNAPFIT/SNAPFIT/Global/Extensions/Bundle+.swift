//
//  Bundle+.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/10.
//

import Foundation

extension Bundle {
    var baseURL: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "SecretKey", ofType: "plist") else {
                fatalError("Couldn't find file 'SecretKey.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "BASE_URL") as? String else {
                fatalError("Couldn't find key 'BASE_URL' in 'SecretKey.plist'.")
            }
            return value
        }
    }
}
