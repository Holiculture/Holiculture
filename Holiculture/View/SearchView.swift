//
//  SearchView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/15.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State var title = "Messages"
    @State var index = 0
    
    @Binding var places: [PlaceDataModel]
    @Binding var tickets: [TicketDataModel]
    @Binding var likes: [LikeDataModel]
    @Binding var selectionTitle: String
    @Binding var searchOption: String
    @Binding var ticketId: Int
    
    @EnvironmentObject var user: uuidVM
    
    @State var concert = TicketDataModel(
        uuid: "",
        _id: -1,
        concert: "",
        address: "",
        date: "",
        seat: "",
        posX: "",
        posY: "",
        img: ""
    )

    
    @State var distance: String = "500"
    
    @State var isLoading = true
    
    @State var isDatePickerVisible: Bool = false
    @State private var schedule = Date()

    
    var body: some View {
        ZStack{
            VStack{
                SearchOption(selectionTitle: $selectionTitle, places: $places, searchOption: $searchOption, distance: $distance, ticketId: $ticketId, isLoading: $isLoading)
                    .padding(.leading, 27)
                    .padding(.trailing, 27)
                    .padding(.bottom, 3)
                    .padding(.top, 60)

                
                selectDistance(ticketId: $ticketId, places: $places, searchOption: $searchOption, distance: $distance, isLoading: $isLoading)


                Spacer()
                
                ScrollView{
                    if isLoading {
                        ProgressView()
                            .tint(Color("HolicBlue"))
                            .padding(.top, 270)
                    }
                    else{
                        if (tickets.isEmpty || places.isEmpty){
                            Text("🔎")
                                .font(.system(size: 90))
                                .padding(.top, 180)
                                .padding(.bottom, 3)
                            Text("검색 결과를 찾을 수 없습니다!")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color("HolicGray"))
                            
                        }else{
                            ForEach($places, id: \.place_name) { place in
                                SpaceCell(place: place, concert: concert)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                } //ScrollView
                
            }//VStack
            HStack{
                GeometryReader { geometry in
                    CustomDropdownMenu(
                        items: tickets.enumerated().map { index, ticket in
                            DropdownItem(id: index + 1, title: ticket.concert, ticketId: ticket._id, onSelect: {})
                        }, selectionTitle: $selectionTitle, places: $places, searchOption: searchOption, distance: distance, isLoading: $isLoading, ticketId: $ticketId
                    )
                    .frame(width: geometry.size.width)
                }
            }//HStack
            .padding(.leading, 25)
            .padding(.trailing, 25)

        }//ZStack
        .padding(.top, 14)
        .onAppear{
            self.isLoading = true
            SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance){ success in
                self.isLoading = false
            }
            
            if let selectedTicket = tickets.first(where: { $0._id == ticketId }) {
                self.concert = selectedTicket
            } else {
                // 처리할 로직 추가: 일치하는 항목을 찾지 못한 경우
            }
        }
    }
}


//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(places: .constant([]), tickets: .constant([]), likes: .constant([]), selectionTitle: .constant(""), searchOption: .constant(""))
//    }
//}
//
