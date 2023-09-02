//
//  SnapfitMoyaProvider.swift
//  SNAPFIT
//
//  Created by Jungbin on 2023/09/01.
//

import Foundation
import Moya

final class SnapfitMoyaProvider<TargetRouter: TargetType>: MoyaProvider<TargetRouter> {
    convenience init(isLoggingOn: Bool = false) {
        self.init(plugins: [NetworkLoggerPlugin()])
    }
}
