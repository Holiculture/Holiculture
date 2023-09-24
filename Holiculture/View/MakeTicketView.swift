//
//  MakeTicketView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/19.
//

import SwiftUI

struct MakeTicketView: View {
    @State private var isActive: Bool = false
    @State private var showingAlert: Bool = false
    @State private var errorAlert: Bool = false
    @State private var presentingNewView: Bool = false
    @State private var activeWebView: Bool = false
    
    @State var concert: String
    @Binding var date: String
    @State private var schedule = Date()
    
    @State var address: String
    @State var seat: String = ""
    @State var img: String
    
    @EnvironmentObject var user: uuidVM
    
    @State private var addedTickets: [TicketDataModel] = []
    
    @Binding var tickets: [TicketDataModel]
    
    @State var isLoading = false
    
    @State private var isDatePickerVisible = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationStack{
            if isLoading {
                ProgressView()
                    .tint(Color("HolicBlue"))
            }
            else{
                ZStack {
                    VStack{
                        Text("티켓 정보 입력")
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 34, bottom: 0, trailing: 239))
                        
                        Text("*는 필수 입력입니다")
                            .font(.system(size: 8))
                            .fontWeight(.regular)
                        //.multilineTextAlignment(.center)
                            .foregroundColor(Color("HolicGray"))
                            .padding(EdgeInsets(top: 0, leading: 276, bottom: 0, trailing: 30))
                        

                        TextField("*공연명", text: $concert)
                            .font(.system(size: 16))
                            .padding()
                            .background(Color(uiColor: .white))
                            .frame(width: 340, height: 56)
                            .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                            .minimumScaleFactor(0.6)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.5)
                                    .stroke(Color("HolicGray"), lineWidth: 1)
                            )
                            .foregroundColor(Color("HolicGray"))
                            .padding(EdgeInsets(top: 5, leading: 27, bottom: 0, trailing: 23))
                        
//                        NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://minchelin42.github.io/Kakao-PostAPI/")!), onDismiss: { receiveAddress in
//                            address = receiveAddress // 주소 데이터를 저장
//                        }), isActive: $activeWebView){
//
                            Button(action: {
                                activeWebView = true
                            }) {
                                HStack{
                                    Text(address.isEmpty ? "*장소" : "\(address)")
                                        .font(.system(size: 16))
                                    //나중에 .gray -> 색상 바꿔야 함
                                        .foregroundColor(address.isEmpty ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color("HolicGray"))
                                        .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                                        .minimumScaleFactor(0.6)
                                        .padding(.leading, 15)
                                    Spacer()
                                }
                            }
                            .background(Color(uiColor: .white))
                            .frame(width: 340, height: 56)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.5)
                                    .stroke(Color("HolicGray"), lineWidth: 1)
                            )
                            .padding(EdgeInsets(top: 14, leading: 27, bottom: 0, trailing: 23))
                            .sheet(isPresented: $activeWebView) {
                                WebView(request: URLRequest(url: URL(string: "https://minchelin42.github.io/Kakao-PostAPI/")!), onDismiss: { receiveAddress in
                                    address = receiveAddress // 주소 데이터를 저장
                                    activeWebView = false
                                })
                            }
                            
//                        }
                        
                        Button(action: {
                            isDatePickerVisible = true
                        }) {
                            HStack{
                                Text(date.isEmpty ? "*일시" : "\(date)")
                                    .font(.system(size: 16))
                                //나중에 .gray -> 색상 바꿔야 함
                                    .foregroundColor(date.isEmpty ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color("HolicGray"))
                                    .padding(.leading, 15)
                                Spacer()
                            }
                        }
                        .background(Color(uiColor: .white))
                        .frame(width: 340, height: 56)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .inset(by: 0.5)
                                .stroke(Color("HolicGray"), lineWidth: 1)
                        )
                        .padding(EdgeInsets(top: 14, leading: 27, bottom: 0, trailing: 23))
                        
                        
                        TextField("좌석", text: $seat)
                            .font(.system(size: 16))
                            .padding()
                            .background(Color(uiColor: .white))
                            .frame(width: 340, height: 56)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.5)
                                    .stroke(Color("HolicGray"), lineWidth: 1)
                            )
                            .foregroundColor(Color("HolicGray"))
                            .padding(EdgeInsets(top: 14, leading: 27, bottom: 0, trailing: 23))
                        
                        HStack{
                            Button(action: {
                                print("티켓 추가 버튼 클릭")
                                addTicket()
//                                self.isLoading = true
                            }) {
                                Text("티켓 추가")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color("HolicBlue"))
                            .cornerRadius(15)
                            .alert(isPresented: $showingAlert) {
                                if errorAlert {
                                    let alert = Alert(
                                        title: Text("필수 정보를 입력해주세요!"),
                                        message: nil,
                                        dismissButton: .default(Text("확인"), action: {
                                            showingAlert = false
                                            errorAlert = false
                                        })
                                    )
                                    return alert
                                } else {
                                    let alert = Alert(
                                        title: Text("티켓 추가 완료!"),
                                        dismissButton: .default(Text("확인"), action: {
                                            showingAlert = false
                                            presentingNewView = true
                                        })
                                    )
                                    return alert
                                }
                            }
                            .fullScreenCover(isPresented: $presentingNewView, content: {
                                ContentView(tickets: tickets)
                            })
                            
                            
                            Button(action: {
                                isActive = true
                            }) {
                                Text("돌아가기")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("HolicGray"))
                            }
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("HolicGray"), lineWidth: 1)
                                    .fullScreenCover(isPresented: $isActive, content: {
                                        ContentView(tickets: tickets)
                                    }))
                        } //HStack
                        //                        .padding(EdgeInsets(top: 48, leading: 71, bottom: 0, trailing: 71))
                        .padding(EdgeInsets(top: 14, leading: 71, bottom: 0, trailing: 71))
                        
                        
                    }//VStack
                    
                    if isDatePickerVisible {
                        Color("HolicGray")
                            .onTapGesture {
                                isDatePickerVisible.toggle()
                            }
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            VStack(spacing: 0) {
                                DatePicker("", selection: $schedule, in: Date()...)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                
                                Button(action: {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy.MM.dd HH시 mm분"
                                    date = dateFormatter.string(from: schedule)
                                    isDatePickerVisible.toggle()
                                }) {
                                    Text("Done")
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(width: 100, height: 40)
                                .background(Color("HolicGray"))
                                .cornerRadius(15)
                                .padding(.bottom, 5)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()
                        }
                        .frame(width: .infinity, height: 500)
                        .background(Color.white)
                        .cornerRadius(30)
                    }
                    
                }//ZStack
            }//else
        }//navigationStack
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
    }
    
    private func addTicket() {
        guard !concert.isEmpty, !date.isEmpty, !address.isEmpty else {
            print("공연명, 일시, 장소는 필수 입력 사항입니다.")
            showingAlert = true
            errorAlert = true
            return
        }
        
        if(seat.isEmpty) {
            seat = "정보없음"
        }
        
        let newTicket = TicketDataModel(uuid: user.uuid, _id: -1, concert: concert, address: address, date: date, seat: seat, posX: "", posY: "", img: img)
        addedTickets.append(newTicket)
        
        //newTicket.sendTicketDataToServer(ticket: newTicket)
        
        TicketManager.shared.sendTicket(uuid: user.uuid, concert: newTicket.concert, address: newTicket.address, date: newTicket.date, seat: newTicket.seat, img: newTicket.img)
        
        tickets.append(newTicket)
        
        print("전체 티켓 목록:")
        for ticket in tickets {
            print(ticket.concert)
        }
        
        concert = ""
        date = ""
        address = ""
        seat = ""
        
        print("티켓 추가 완료!")
        showingAlert = true
        errorAlert = false
        
        TicketManager.shared.getTicket(uuid: user.uuid, tickets: $tickets){ success in
            self.isLoading = false
        }
        
    }
    
    
}


//struct MakeTicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        MakeTicketView(concert: "", date: .constant(""), tickets: .constant([]))
//    }
//}
