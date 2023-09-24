//
//  HolicultureApp.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/15.
//

import SwiftUI
import TAKUUID

@main

struct HolicultureApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(idVM())
                .environmentObject(uuidVM())
        }
    }
}




