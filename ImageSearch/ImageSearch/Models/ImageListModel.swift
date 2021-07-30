//
//  ImageListModel.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation
struct ImageListModel: Decodable {
    let _type: String?
    let totalCount: Double?
    var value: [ImageDataModel]
    mutating func clear() {
        value.removeAll()
    }
}
