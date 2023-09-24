//
//  ticketCell.swift/Users/min/Desktop/Holiculture/Holiculture/View/MakeTicketView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/22.
//

import SwiftUI

struct TicketCell: View {
    @Binding var ticket: TicketDataModel
    @Binding var isActive: Bool
    @Binding var tickets: [TicketDataModel]
    
    @EnvironmentObject var ticketId: idVM
    
    @Binding var isLoading: Bool
    
    var body: some View {
        Button(action: {
            print("티켓 클릭")
            isActive = true
            print("클릭한 티켓: \(ticket.uuid)")
            print("해당 티켓의 index: \(ticket._id)")
            ticketId.updateIndex(targetIndex: ticket._id)
        }) {
            VStack {
                HStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 2, height: 15)
                        .background(Color("HolicGray").opacity(0.4))

                    Text(ticket.concert)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)

                }
                .padding(.bottom, 13)

                Text("장소 : \(ticket.address)")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.bottom, 1)
                
                Text("일시 : \(ticket.date)")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.bottom, 1)

                Text("좌석 : \(ticket.seat)")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)

            } //VStack
            .frame(width: 180, alignment: .leading)
            .padding(.leading, 24)
            Spacer()


        }
        .foregroundColor(.clear)
        .frame(width: 353, height: 156)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.5)
                .stroke(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4), lineWidth: 1)
        )
        
        .fullScreenCover(isPresented: $isActive, content: {
            EditTicketView(isEditing: $isActive, tickets: $tickets, targetTicket: tickets[0], isLoading: $isLoading)
        })

    }
}


