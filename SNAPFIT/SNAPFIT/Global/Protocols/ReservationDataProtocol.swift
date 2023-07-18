//
//  SendDateData.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/09.
//

import Foundation

public protocol DateDataDelegate {
    
    func recieveDateData(date: Date)
}

public protocol ReservationDataDelegate: DateDataDelegate {
    func recieveReservationData(name: String, date: Date, contents: String)
}
