//
//  ConcertDataModel.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/20.
//

import Foundation

struct ConcertDataModel: Codable{
    var _id: Int
    var title: String
    var startDate: String
    var endDate: String
    var titleImg: String
    var location: String
    var cate: String
    var address: String
    var summary: String
    var cast: String
    var crew: String
    var runtime: String
    var age: String
    var producer: String
    var price: String
    var time: String
    var openrun: String
    var subImgs: [String]
}
