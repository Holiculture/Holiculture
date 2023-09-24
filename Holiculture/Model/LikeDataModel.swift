//
//  LikeDataModel.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/17.
//

import Foundation

struct LikeDataModel: Codable{
    var uuid: String
    var _id: Int
    var place_name: String
    var place_url: String
    var category_name: String
    var distance: String
    var road_address_name: String
    var cate: String
    var img: String
    var isLike: Bool
    var x: String
    var y: String
}
