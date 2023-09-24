////
////  dropDown수정.swift
////  Holiculture
////
////  Created by 민지은 on 2023/08/13.
////
//
//
//import SwiftUI
//
//struct CustomDropdownMenu: View {
//    @State var isSelecting = false
//    @State var selectedRowId = 0
//    @State var selectionTitle = ""
//    let items: [DropdownItem]
//
//    var body: some View {
//        GeometryReader { _ in
//            VStack {
//                HStack {
//                    Text(items[0].title)
//                        .font(.system(size: 16, weight: .semibold, design: .rounded))
//                        .animation(.none)
//                    Spacer()
//                    Image(systemName: (isSelecting ? "chevron.up" : "chevron.down"))
//                        .font(.system(size: 16, weight: .semibold))
//                        //.rotationEffect(.degrees( isSelecting ? -180 : 0))
//                    
//                }
//                .padding(.horizontal)
//                .foregroundColor(Color("HolicGray"))
//                
//                if isSelecting {
////                    Divider()
////                        .background(.white)
////                        .padding(.horizontal)
//                    
//                    VStack(spacing: 5) {
//                        dropDownItemsList()
//                    }
//                }
//                
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.vertical)
//            .background(.gray)
//            .cornerRadius(10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: 1)
//            )
//            .onTapGesture {
//                isSelecting.toggle()
//            }
//            .onAppear {
//                selectedRowId = items[0].id
//                selectionTitle = items[0].title
//            }
//
//            .animation(.easeInOut(duration: 0.4))
//        }
//        
//    }
//    
//    private func dropDownItemsList() -> some View {
//        ForEach(items) { item in
//            DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: selectionTitle, selectionId: selectedRowId, item: items[selectedRowId])
//        }
//    }
//}
//
//struct DropdownItem: Identifiable {
//    let id: Int
//    let title: String
//    let onSelect: () -> Void
//}
//
//struct DropdownMenuItemView: View {
//    @Binding var isSelecting: Bool
//    @State var selectiontitle: String
//    @State var selectionId: Int
//    let item: DropdownItem
//    
//    var body: some View {
//        Button(action: {
//            isSelecting = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                selectionId = item.id
//            }
//            selectiontitle = item.title
//            item.onSelect()
//
//            print("id: \(item.id)")
//        }) {
//            HStack {
//                Image(systemName: "checkmark")
//                    .font(.system(size: 14, weight: .bold))
//                    .opacity(selectionId == item.id ? 1 : 0)
//                Text(item.title)
//                    .font(.system(size: 16, weight: .regular, design: .rounded))
//
//                Spacer()
//            }
//            .padding(.horizontal)
//            .padding(.vertical, 10)
//            
//            .foregroundColor(Color("HolicGray"))
//
//        }
//    }
//}
//
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
//
