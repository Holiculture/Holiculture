//
//  ContentView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/15.
//

import SwiftUI

struct TicketView: View {
    
    @Binding var tickets: [TicketDataModel]
    @State var isActive: Bool = false
    @EnvironmentObject var user: uuidVM
    @State var concerts: [ConcertDataModel] = []
    
    @State var isLoading = true
    
    var body: some View {
        NavigationStack{
            VStack{
                if !isLoading{
                    appLogo()
                }
                ZStack {
                    if isLoading {
                        ProgressView()
                            .tint(Color("HolicBlue"))
                    } else {
                        if tickets.isEmpty {
                            EmptyTicket()
                        } else {
                            ScrollView {
                                ForEach($tickets, id: \._id) { ticket in
                                    TicketCell(ticket: ticket, isActive: $isActive, tickets: $tickets, isLoading: $isLoading)
                                }
                                .frame(maxWidth: .infinity)
                            } // ScrollView
                            .padding(.top, 15)
                        }
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                plusButton(tickets: $tickets)
                            }
                            .padding(.trailing, 20)
                        }
                        .padding(.bottom, 20)
                    }
                    
                } // ZStack
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            print("user UUID : \(user.uuid)")
            isLoading = true
            TicketManager.shared.getTicket(uuid: user.uuid, tickets: $tickets) { success in
                isLoading = false
                if success {
                    print("전체 티켓 목록:")
                    for ticket in tickets {
                        print(ticket.concert)
                    }
                } else {
                    print("티켓 조회 실패")
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
