//
//  SwiftUIView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/21.
//

import SwiftUI

struct SearchOption: View {
    @State var foodActive: Bool = false
    @State var roomActive: Bool = false
    @State var playActive: Bool = false
    
    @EnvironmentObject var user: uuidVM
    @Binding var selectionTitle: String
    @Binding var places: [PlaceDataModel]
    @Binding var searchOption: String
    @Binding var distance: String
    @Binding var ticketId: Int
    
    @Binding var isLoading: Bool
    
    
    var body: some View {
        HStack{
            Button(action: {
                print("식당 찾기 클릭")
                isLoading = true
                foodActive = true
                roomActive = false
                playActive = false
                
                searchOption = "food"
                SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance)
                { success in
                    isLoading = false
                }
            }) {
                Text("🍽️ 식당")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(foodActive ? .white : Color("HolicGray"))
            }
            .padding()
            .frame(width: 100, height: 35)
            .background(foodActive ? Color("HolicGray") : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("HolicGray"), lineWidth: foodActive ? 0 : 1)
            )
            Spacer()
            
            Button(action: {
                print("숙소 찾기 클릭")
                isLoading = true
                foodActive = false
                roomActive = true
                playActive = false
                
                searchOption = "room"
                SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance)
                { success in
                    isLoading = false
                }
            }) {
                Text("🏠 숙소")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(roomActive ? .white : Color("HolicGray"))
            }
            
            .padding()
            .frame(width: 100, height: 35)
            .background(roomActive ? Color("HolicGray") : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("HolicGray"), lineWidth: roomActive ? 0 : 1)
            )
            Spacer()
            
            Button(action: {
                print("즐길거리 찾기 클릭")
                isLoading = true
                foodActive = false
                roomActive = false
                playActive = true
                
                searchOption = "play"
                SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance)
                { success in
                    isLoading = false
                }
            }) {
                Text("🎡 즐길거리")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(playActive ? .white : Color("HolicGray"))
            }
            .padding()
            .frame(width: 100, height: 35)
            .background(playActive ? Color("HolicGray") : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("HolicGray"), lineWidth: playActive ? 0 : 1)
            )
        }
        .onAppear{
            foodActive = true
            roomActive = false
            playActive = false
            searchOption = "food"
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchOption()
//    }
//}
