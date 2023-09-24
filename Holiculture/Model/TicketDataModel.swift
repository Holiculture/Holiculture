//
//  TicketDataModel.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/02.
//

import Foundation

struct TicketDataModel: Codable {
    var uuid: String
    var _id: Int
    var concert: String
    var address: String
    var date: String
    var seat: String
    var posX: String
    var posY: String
}



