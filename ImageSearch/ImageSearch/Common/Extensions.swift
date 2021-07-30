//
//  Extensions.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation

extension Bool {
    func toString() -> String {
        if self { return "true" }
        else { return "false" }
    }
}
extension String {
    func fileName() -> String {
        return self.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "/", with: "")
    }
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
