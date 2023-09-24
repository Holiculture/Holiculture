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
    @State var isNavigationActive = false
    
    @EnvironmentObject var ticketId: idVM
    
    @Binding var isLoading: Bool

    var body: some View {
//        NavigationStack{
//            NavigationLink(destination: EditTicketView(isEditing: $isActive, tickets: $tickets, targetTicket: tickets[0], isLoading: $isLoading), isActive: $isNavigationActive){
//
                Button(action: {
                    print("티켓 클릭")
                    isActive = true
                    isNavigationActive = true
                    print("클릭한 티켓: \(ticket.uuid)")
                    print("해당 티켓의 index: \(ticket._id)")
                    ticketId.updateIndex(targetIndex: ticket._id)
                }) {
                    HStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 90, height: 120)
                            .background(
                                AsyncImage(url: URL(string: ticket.img)) { phase in
                                    switch phase {
                                    case .empty:
                                        Image("image1") // ticket.img가 비어 있을 때 기본 이미지로 설정
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 120)
                                            .clipped()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 120)
                                            .clipped()
                                    case .failure(let error):
                                        Image("image1") // 이미지 로드 실패 시 기본 이미지로 설정
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 120)
                                            .clipped()
                                    }
                                }
                            )

                            .cornerRadius(0)
                            .padding(.trailing, 7)
                        
                        VStack {
                            HStack{
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 2, height: 15)
                                    .background(Color("HolicBlue"))
                                
                                Text(ticket.concert)
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .minimumScaleFactor(0.7)
                                    .foregroundColor(.black)
           
                            }
                            .padding(.bottom, 13)
                            
                            Text("장소 : \(ticket.address)")
                                .font(.system(size: 11))
                                .fontWeight(.semibold)
                                .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .minimumScaleFactor(0.7)
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
                        .frame(maxWidth: 220, alignment: .leading)
                        
                        //                .background(.blue)
                        //                .padding(.leading, 24)
                        
                    }
                    
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
                .sheet(isPresented: $isNavigationActive) {
                    EditTicketView(isEditing: $isActive, tickets: $tickets, targetTicket: tickets[0], isLoading: $isLoading, findTicket: false)
                }
//            }
//        }
        
  
    }//body
}//view



struct ticketCell_Previews: PreviewProvider {
    static var previews: some View {
        TicketCell(ticket: .constant(TicketDataModel(
            uuid: "",
            _id: -1,
            concert: "오페라의 유령",
            address: "으아아dkdkdkdkdkdkdkdkdk",
            date: "2023.09.20 11시 20분",
            seat: "String",
            posX: "String",
            posY: "String",
            img: "img"
        )),isActive: .constant(false), tickets: .constant([ TicketDataModel(
            uuid: "",
            _id: -1,
            concert: "오페라의 유령오페라의 유령오페라의 유령오페라의 유령",
            address: "으아아아ㅏ아아아아아아ㅏ아아아ㅏ",
            date: "2023.09.20 11시 20분",
            seat: "String",
            posX: "String",
            posY: "String",
            img: "img"
        )]), isLoading: .constant(false))
    }
}
