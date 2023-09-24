//
//  datePicker.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/28.
//

import SwiftUI

struct selectDistance: View {
    @State var selectedIndex = 0
    var titles = ["0.5Km", "1km", "1.5km", "2km", "2.5km", "3km"]
    var distanceList = ["500", "1000", "1500", "2000", "2500", "3000"]
    var colors = Color("HolicGray")
    @State var frames = Array<CGRect>(repeating: .zero, count: 6)
    
    @EnvironmentObject var user: uuidVM
    
    @Binding var ticketId: Int
    @Binding var places: [PlaceDataModel]
    @Binding var searchOption: String
    @Binding var distance: String
    @Binding var isLoading: Bool
    @Binding var pageNum: Int
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { self.selectedIndex = index
                            distance = distanceList[index]
                            isLoading = true
                            pageNum = 1
                            SearchManager.shared.getPlace(uuid: user.uuid, ticketId: ticketId, places: $places, option: searchOption, distance: distance, pageNum: pageNum){ success in
                                isLoading = false
                            }
                        }) {
                            Text(self.titles[index])
                                .font(.system(size:12))
                                .foregroundColor(Color("HolicGray"))
                        }.padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }
                .background(
                    Capsule()
                        .stroke(Color("HolicGray"), lineWidth: 1)
                        .frame(width: self.frames[self.selectedIndex].width,
                               height: self.frames[self.selectedIndex].height, alignment: .topLeading)
                        .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX)
                    , alignment: .leading
                )
            }
            .animation(.default)
        }
        .onAppear{
            distance = "500"
            self.selectedIndex = 0
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}
