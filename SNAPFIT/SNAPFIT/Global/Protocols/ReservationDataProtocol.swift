//
//  SendDateData.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/06/09.
//

import Foundation

protocol ReservationDataDelegate: DateDataDelegate {
    func recieveReservationData(reservationData: Reservation)
}
