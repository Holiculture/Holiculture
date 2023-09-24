//
//  plusButton.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/26.
//

import SwiftUI

struct plusButton: View {
    @State private var isActive: Bool = false
    @Binding var tickets: [TicketDataModel]

    var body: some View {
        Button(action: {
            isActive = true
        }) {
            Text("+")
                .font(.system(size: 30))
                .fontWeight(.regular)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 60, height: 60)
        .background(Color("HolicGray"))
        .clipShape(Circle())
        .shadow(color: Color.gray, radius: 3, x: 3, y: 3)

        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color("HolicGray"), lineWidth: 1))

        .fullScreenCover(isPresented: $isActive, content: {
            MakeTicketView(tickets: $tickets)
        })
    }
}



struct plusButton_Previews: PreviewProvider {
    static var previews: some View {
        plusButton(tickets: .constant([]))
    }
}
