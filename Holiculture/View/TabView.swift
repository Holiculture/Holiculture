//
//  TabView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/26.
//

import SwiftUI

struct ContentView: View {
    @State var tickets: [TicketDataModel] = []
    @State var places: [PlaceDataModel] = []
    @State var likes: [LikeDataModel] = []
    @State var selectionTitle: String = ""
    @State var ticketId: Int = -1
    @State var searchOption: String = ""
    //    @State var isActive: Bool = false
    var startLike = LikeDataModel(uuid: "",
                                  _id: -1,
                                  place_name: "",
                                  place_url: "",
                                  category_name: "",
                                  distance: "",
                                  road_address_name: "",
                                  //                                 cate: "",
                                  img: "",
                                  isLike: true,
                                  x: "",
                                  y: "")
    
    var finishLike = LikeDataModel(uuid: "",
                                   _id: -1,
                                   place_name: "",
                                   place_url: "",
                                   category_name: "",
                                   distance: "",
                                   road_address_name: "",
                                   //                                 cate: "",
                                   img: "",
                                   isLike: true,
                                   x: "",
                                   y: "")
    
    
    var body: some View {
        TabView {
            TicketView(tickets: $tickets)
                .tabItem {
                    Image(systemName: "person.text.rectangle")
                    Text("Ticket")
                }
            
            SearchView(places: $places, tickets: $tickets, likes: $likes, selectionTitle: $selectionTitle, searchOption: $searchOption, ticketId: $ticketId)
                .tabItem{
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                }
            
            WishView(tickets: $tickets, likes: $likes, startLike: startLike, finishLike: finishLike)
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("My Place")
                }
            NavigationStack{
                NowConcertView()
            }
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Now play")
                }
        }
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white
        }

        
    }
}
