//
//  CustomDropdownMenu.swift
//  CustomDropdownMenu
//
//  Created by Everton Carneiro on 05/02/22.
//



import SwiftUI

struct CustomDropdownMenu: View {
    @State var isSelecting = false
    @State var selectedRowId = 0
    let items: [DropdownItem]
    
    @Binding var selectionTitle: String
    @Binding var places: [PlaceDataModel]
    var searchOption: String
    var distance: String
    
    @Binding var isLoading: Bool
    @Binding var ticketId: Int
    @Binding var pageNum: Int

    var body: some View {
        GeometryReader { _ in
            VStack {
                HStack {
                    Text(selectionTitle)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .animation(.none)
                        .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Image(systemName: (isSelecting ? "chevron.up" : "chevron.down"))
                        .font(.system(size: 16, weight: .semibold))
                        //.rotationEffect(.degrees( isSelecting ? -180 : 0))
                    
                }
                .padding(.horizontal)
                .foregroundColor(Color("HolicGray"))
                
                if isSelecting {
//                    Divider()
//                        .background(.white)
//                        .padding(.horizontal)
                    VStack(spacing: 5) {
                        dropDownItemsList()
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: 1)
            )
            .onTapGesture {
                if(items.count >= 1){
                    isSelecting.toggle()
                }
            }
//            .onAppear {
//                selectedRowId = items[0].id
//                selectionTitle = items[0].title
//                ticketId = items[0].ticketId
//            }
            .onAppear {
                if items.isEmpty {
                    selectedRowId = -1
                    selectionTitle = "등록된 티켓이 없습니다"
                } else {
                    selectedRowId = items[0].id
                    selectionTitle = items[0].title
                    ticketId = items[0].ticketId
                }
            }

            .animation(.easeInOut(duration: 0.4))
        }
        
    }
    
    private func dropDownItemsList() -> some View {
        ForEach(items) { item in
            DropdownMenuItemView(isSelecting: $isSelecting, selectionId: $selectedRowId, selectiontitle: $selectionTitle, ticketId: $ticketId, searchOption: searchOption, distance: distance, item: item, places: $places, isLoading: $isLoading, pageNum: $pageNum)
        }
    }
}

struct DropdownItem: Identifiable {
    let id: Int
    let title: String
    let ticketId: Int
    let onSelect: () -> Void
}

struct DropdownMenuItemView: View {
    @Binding var isSelecting: Bool
    @Binding var selectionId: Int
    @Binding var selectiontitle: String
    @Binding var ticketId: Int
    var searchOption: String
    var distance: String
    
    let item: DropdownItem
    
    @EnvironmentObject var user: uuidVM
    @Binding var places: [PlaceDataModel]

    @Binding var isLoading: Bool
    @Binding var pageNum: Int
    
    var body: some View {
        Button(action: {
            isSelecting = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                selectionId = item.id
            }
            selectiontitle = item.title
            ticketId = item.ticketId
            item.onSelect()
            
            isLoading = true
            pageNum = 1
            SearchManager.shared.getPlace(uuid: user.uuid, ticketId: item.ticketId, places: $places, option: searchOption, distance: distance, pageNum: pageNum) { success in
                isLoading = false
            }
            
            print("id: \(item.id)")
            print("title: \(item.title)")
            print("ticketId: \(item.ticketId)")
        }) {
            HStack {
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .opacity(selectionId == item.id ? 1 : 0)
                Text(item.title)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                    .minimumScaleFactor(0.7)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            .foregroundColor(Color("HolicGray"))

        }
    }
}

//struct CustomDropdownMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDropdownMenu(items: [
//            DropdownItem(id: 1, title: "블루스퀘어", onSelect: {}),
//            DropdownItem(id: 2, title: "yes24라이브홀", onSelect: {}),
//            DropdownItem(id: 3, title: "충무아트센터", onSelect: {})
//        ])
//            .padding(.horizontal)
//    }
//}
//


