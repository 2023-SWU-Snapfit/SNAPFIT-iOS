//
//  UserDataMethodManager.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/11/23.
//

import Foundation

enum UserPosition: String {
    case general = "GENERAL"
    case photographer = "PHOTOGRAPHER"
}

func getMyUserPosition() -> String {
    var positionData: String = ""
    getMyUserData { result in
        positionData = result.position
        print("There is the \(positionData)")
    }
    print("Here is the \(positionData)")
    return positionData
}

func getMyUserData(completion: @escaping(UserDetailResponseDTO) -> ()) {
    UserService.shared.getUserDetail(targetId: UserInfo.shared.userID) { networkResult in
        switch networkResult {
        case .success(let responseData):
            if let result = responseData as? UserDetailResponseDTO {
                completion(result)
            }
        case .requestErr(_):
            print("requestError")
        case .pathErr:
            print("pathErr")
        case .serverErr:
            print("serverErr")
        case .networkFail:
            print("networkErr")
        }
    }
}

func getUserData(targetID: Int, completion: @escaping(UserDetailResponseDTO) -> ()) {
    UserService.shared.getUserDetail(targetId: targetID) { networkResult in
        switch networkResult {
        case .success(let responseData):
            if let result = responseData as? UserDetailResponseDTO {
                completion(result)
            }
        case .requestErr(_):
            print("requestError")
        case .pathErr:
            print("pathErr")
        case .serverErr:
            print("serverErr")
        case .networkFail:
            print("networkErr")
        }
    }
}
