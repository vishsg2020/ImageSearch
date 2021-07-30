//
//  SearchRequestParam.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation
struct SearchRequestParam {
    let searchKey: String
    let pageNumber: Int
    let pageSize: Int = 10
    let autoCurrect: Bool = true
}
