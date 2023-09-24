//
//  UserUUID.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/04.
//

import Foundation
import TAKUUID

class uuidVM: ObservableObject {
    @Published var uuid: String = ""
    
    init() {
        if let savedUUID = UserDefaults.standard.string(forKey: "AppUUID") {
            self.uuid = savedUUID
        } else {
            initUUID()
        }
    }
    
    private func initUUID() {
        TAKUUIDStorage.sharedInstance().migrate()
        self.uuid = TAKUUIDStorage.sharedInstance().findOrCreate()!
        UserDefaults.standard.set(self.uuid, forKey: "AppUUID")
    }
}

