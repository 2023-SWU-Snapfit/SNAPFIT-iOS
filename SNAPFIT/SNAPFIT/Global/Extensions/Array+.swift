//
//  Array+.swift
//  SNAPFIT
//
import Foundation

extension Array {
    func getTagText() -> String {
        var result = ""
        self.forEach { element in
            if let tagNum: Int = element as? Int {
                result.append("#\(tagNum.getTagName()) ")
            }
        }
        
        return result
    }
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
