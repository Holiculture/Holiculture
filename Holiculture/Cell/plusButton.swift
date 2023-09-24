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
        NavigationStack{
            NavigationLink(destination: DateInputView(tickets: $tickets), isActive: $isActive){
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
                .background(Color("HolicBlue"))
                .clipShape(Circle())
                .shadow(color: Color.gray, radius: 3, x: 3, y: 3)
//                            .fullScreenCover(isPresented: $isActive, content: {
//                                DateInputView(tickets: $tickets)
//                            })
            }
        }
        
            
            
    }
}



struct plusButton_Previews: PreviewProvider {
    static var previews: some View {
        plusButton(tickets: .constant([]))
    }
}
