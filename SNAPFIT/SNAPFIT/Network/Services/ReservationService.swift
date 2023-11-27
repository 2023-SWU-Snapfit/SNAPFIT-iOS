//
//  ReservationService.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/10/07.
//

import Foundation
import Moya

internal protocol ReservationServiceProtocol {
    func getReservationList(_ reserveType: ReservationListResponseDTOElement.ReserveType, startTime: Date, endTime: Date, completion: @escaping (NetworkResult<Any>) -> (Void))
    func getReservationDetail(reservationId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
    func postReservation(data: ReservationPostRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func putReservation(data: ReservationPutRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class ReservationService: BaseService {
    static let shared = ReservationService()
    private lazy var provider = SnapfitMoyaProvider<ReservationRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension ReservationService: ReservationServiceProtocol {
    
    func getReservationList(_ reserveType: ReservationListResponseDTOElement.ReserveType, startTime: Date, endTime: Date, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getReservationList(type: reserveType, startTime: startTime, endTime: endTime)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ReservationListResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getReservationDetail(reservationId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        self.provider.request(.getReservationDetail(reservationId: reservationId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ReservationDetailResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func postReservation(data: ReservationPostRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        self.provider.request(.postReservation(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ReservationPostRequestDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func putReservation(data: ReservationPutRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        self.provider.request(.putReservation(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ReservationPutRequestDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
