//
//  Array+.swift
//  SNAPFIT
//
//  Created by Jungbin on 11/29/23.
//

import Foundation

extension Array {
    func makeFormDataString() -> String {
        var string = "{"
        self.forEach {
            string.append("\($0), ")
        }
        string.removeLast(2)
        string.append("}")
        return string
    }
}
