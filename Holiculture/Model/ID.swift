//
//  ID.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/31.
//
import SwiftUI

class idVM: ObservableObject {
    @Published var idIndex: Int = 0

    func updateIndex(targetIndex: Int){
        idIndex = targetIndex
    }
}
