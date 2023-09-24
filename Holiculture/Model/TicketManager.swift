//
//  TicketManager.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/29.
//

import Foundation

class TicketManager: ObservableObject {
    @Published var tickets: [TicketData] = []
}
