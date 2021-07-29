//
//  ImageDataModel.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import Foundation
struct ImageDataModel: Decodable {
    let imageName: String
    let imageTitle: String
    let imageUrl: String
    let thumbImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageName = "name"
        case imageTitle = "title"
        case imageUrl = "url"
        case thumbImageUrl = "thumbnail"
    }
}
