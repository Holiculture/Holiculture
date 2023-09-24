//
//  EditConcertSearchView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/21.
//

import SwiftUI

struct EditConcertSearchView: View {
    @State var concerts: [ConcertDataModel] = []
    @Binding var tickets: [TicketDataModel]
    @Binding var date: String
    @State private var searchText: String = ""
    @State var isActive: Bool = false
    @State var isLoading: Bool = true
    @State var backHome: Bool = false
    let names = ["Jane", "Harry", "Jason", "John", "Ahna", "Ted", "Jelly"]
    @State var backList = false
    @EnvironmentObject var user: uuidVM
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var _id: Int
    @State var seat: String
    var body: some View {
            NavigationView {
                
                if isLoading{
                    ProgressView()
                        .tint(Color("HolicBlue"))
                }
                else{
                    if searchResults.count != 0 {
                        List {
                            //                    ForEach(searchResults, id: \.self) { concert in
                            //                        NavigationLink {
                            //                            MakeTicketView(concert: concert, date: $date, tickets: $tickets)
                            //                        } label: {
                            //                            Text(concert)
                            //                        }
                            //                    }
                            
                            ForEach (searchResults, id: \._id) { concert in
                                ZStack {
//                                    NavigationLink(destination : EditTicketView(isEditing: $isActive, tickets: $tickets, targetTicket: TicketDataModel(uuid: user.uuid, _id: self._id, concert: concert.title, address: concert.address, date: date, seat: self.seat, posX: "", posY: "", img: concert.titleImg), isLoading: $isLoading, findTicket: true)) {
//                                        EmptyView()
//                                    }
                                    NavigationLink(destination : EditConcertInfo(tickets: $tickets, targetTicket: TicketDataModel(uuid: user.uuid, _id: self._id, concert: concert.title, address: concert.address, date: date, seat: self.seat, posX: "", posY: "", img: concert.titleImg), isLoading: $isLoading, concert: concert)){
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    HStack {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 70, height: 87)
                                            .background(
                                                AsyncImage(url: URL(string: concert.titleImg)) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        Image("image1") // ticket.img가 비어 있을 때 기본 이미지로 설정
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 70, height: 87)
                                                            .clipped()
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 70, height: 87)
                                                            .clipped()
                                                    case .failure(let error):
                                                        Image("image1") // 이미지 로드 실패 시 기본 이미지로 설정
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 70, height: 87)
                                                            .clipped()
                                                    }
                                                }
                                            )
                                            .cornerRadius(0)
                                            .padding(.trailing, 8)
                                        
                                        Text(concert.title)
                                            .frame(maxWidth: 330, alignment: .leading)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.7)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 7)
                                            .foregroundColor(Color("HolicBlue"))
                                    }
                                }
                            }
                        }
                        .background(.white)
                        .scrollContentBackground(.hidden)
                        
                    }
                    else{
                        VStack(spacing: 30){
                            EmptyConcert()
                            
                            NavigationLink(destination : MakeTicketView(concert: "", date: $date, address: "", img: "", tickets: $tickets),isActive: $isActive) {
                                Button(action: {
                                    print("다음 버튼 클릭")
                                    isActive = true
                                }) {
                                    Text("입력하기")
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color("HolicBlue"))
                                .cornerRadius(15)
//                                .fullScreenCover(isPresented: $isActive, content: {
//                                    MakeTicketView(concert: "", date: $date, address: "", img: "", tickets: $tickets, gotoList: $gotoList)
//                                })
                            }

                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "공연명 검색")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                            .foregroundColor(Color("HolicBlue"))
                    }
                }
            }
            .onAppear{
                ConcertManager.shared.getConcertList(concerts: $concerts, date: date){ success in
                    isLoading = false
                    if success {
                        print("전체 콘서트 목록:")
                        for concert in concerts {
                            print(concert.title)
                        }
                    } else {
                        print("티켓 조회 실패")
                    }
                }
            }
        }
//    }

    var searchResults: [ConcertDataModel] {
        if searchText.isEmpty {
            return concerts
        } else {
            return concerts.filter { $0.title.contains(searchText) }
        }
    }

}
//
//struct ConcertSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConcertSearchView(tickets: .constant([]), date: .constant(""))
//    }
//}
