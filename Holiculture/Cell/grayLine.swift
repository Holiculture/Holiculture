//
//  SwiftUIView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/21.
//
import SwiftUI

struct GrayLine: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 344, height: 1)
            .background(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4))
    }
}
