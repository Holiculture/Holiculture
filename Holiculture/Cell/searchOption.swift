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
    
    @Binding var pageNum: Int
    
    
    var body: some View {
        HStack{
            Button(action: {
                print("식당 찾기 클릭")
                isLoading = true
                foodActive = true
                roomActive = false
                playActive = false
                
                searchOption = "food"
                pageNum = 1
                SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance, pageNum: pageNum)
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
            .frame(width: 100, height: 37)
            .background(foodActive ? Color("HolicBlue") : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: foodActive ? 0 : 1)
            )
            Spacer()
            
            Button(action: {
                print("숙소 찾기 클릭")
                isLoading = true
                foodActive = false
                roomActive = true
                playActive = false
                
                searchOption = "room"
                pageNum = 1
                SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance, pageNum: pageNum)
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
            .frame(width: 100, height: 37)
            .background(roomActive ? Color("HolicBlue") : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: roomActive ? 0 : 1)
            )
            Spacer()
            
            Button(action: {
                print("즐길거리 찾기 클릭")
                isLoading = true
                foodActive = false
                roomActive = false
                playActive = true
                
                searchOption = "play"
                pageNum = 1
                SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance, pageNum: pageNum)
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
            .frame(width: 100, height: 37)
            .background(playActive ? Color("HolicBlue") : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: playActive ? 0 : 1)
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
