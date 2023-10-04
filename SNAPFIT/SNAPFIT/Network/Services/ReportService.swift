//
//  ReportService.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/04.
//

import Foundation
internal protocol ReportServiceProtocol {
    func postReport(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class ReportService: BaseService {
    static let shared = ReportService()
    private lazy var provider = SnapfitMoyaProvider<ReportRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension ReportService: ReportServiceProtocol {
    func postReport(targetId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        self.provider.request(.postReport(targetId: targetId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ReportRequestDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
        
}
