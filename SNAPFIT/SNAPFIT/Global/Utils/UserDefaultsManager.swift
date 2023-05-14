//
//  UserDefaultsManager.swift
//  SNAPFIT
//
//  Created by madilyn on 2023/05/14.
//

import Foundation

struct UserDefaultsManager {
    static var userID: Int? {
        get { return UserDefaults.standard.integer(forKey: UserDefaults.Keys.userID) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.userID) }
    }
}
