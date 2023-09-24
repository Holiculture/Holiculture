//
//  MakeTicketView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/30.
//

import SwiftUI

struct EditTicketView: View {
    @Binding var isEditing: Bool
    @Binding var tickets: [TicketDataModel]

    @State var targetTicket: TicketDataModel
    
    @State private var showingAlert: Bool = false
    @State private var showingDeleteAlert: Bool = false
    @State private var goHome: Bool = false

    @State private var schedule = Date()

    @EnvironmentObject var user: uuidVM
    @EnvironmentObject var ticketId: idVM
    
    @Binding var isLoading: Bool
    @State var editAble: Bool = false
    
    @State private var isDatePickerVisible = false
    @State private var activeWebView = false
    @State private var isActive = false
    
    @State var findTicket: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationStack{
            VStack {
                if isLoading {
                    ProgressView()
                        .tint(Color("HolicBlue"))
                }
                else{
                    ZStack{
                        
                        VStack{
                            Text("티켓 정보 수정")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 34, bottom: 0, trailing: 239))
                            
                            Text("*는 필수 입력입니다")
                                .font(.system(size: 8))
                                .fontWeight(.regular)
                                .foregroundColor(Color("HolicGray"))
                                .padding(EdgeInsets(top: 0, leading: 276, bottom: 0, trailing: 30))
                            
                            NavigationLink(destination: EditConcertSearchView(tickets: $tickets, date: $targetTicket.date, _id: targetTicket._id, seat: targetTicket.seat), isActive: $isActive){
                                Button(action: {
                                    isActive = true
                                }) {
                                    HStack{
                                        Text(targetTicket.address.isEmpty ? "*공연명" : "\(targetTicket.concert)")
                                            .font(.system(size: 16))
                                        //나중에 .gray -> 색상 바꿔야 함
                                            .foregroundColor(targetTicket.address.isEmpty ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color("HolicGray"))
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
//                                .fullScreenCover(isPresented: $isActive, content: {
//                                    EditConcertSearchView(tickets: $tickets, date: $targetTicket.date, _id: targetTicket._id, seat: targetTicket.seat)
//                                })
                                
                            }
                            
//                            NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://minchelin42.github.io/Kakao-PostAPI/")!), onDismiss: { receiveAddress in
//                                targetTicket.address = receiveAddress // 주소 데이터를 저장
//                            }), isActive: $activeWebView){
                                
                                Button(action: {
                                    activeWebView = true
                                }) {
                                    HStack{
                                        Text(targetTicket.address.isEmpty ? "*장소" : "\(targetTicket.address)")
                                            .font(.system(size: 16))
                                        //나중에 .gray -> 색상 바꿔야 함
                                            .foregroundColor(targetTicket.address.isEmpty ? Color(red: 0.80, green: 0.80, blue: 0.80) : Color("HolicGray"))
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
                                        targetTicket.address = receiveAddress // 주소 데이터를 저장
                                        activeWebView = false
                                    })
                                }
                                
//                            }
                            
                            Text((targetTicket.date).isEmpty ? "*일시" : "\(targetTicket.date)")
                                .font(.system(size: 16))
                                .padding()
                                .background(Color(uiColor: .white))
                                .frame(width: 340, height: 56, alignment: .leading)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.5)
                                        .stroke(Color("HolicGray"), lineWidth: 1)
                                )
                                .foregroundColor((targetTicket.date).isEmpty ? Color(red: 0.77, green: 0.77, blue: 0.77) : Color("HolicGray"))
                                .padding(EdgeInsets(top: 14, leading: 27, bottom: 0, trailing: 23))
                                .onTapGesture {
                                    isDatePickerVisible.toggle()
                                }
                            
                            TextField("좌석", text: $targetTicket.seat) // 수정된 부분
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
                            
                            
                            HStack {
//                                NavigationLink(destination: ContentView(tickets: tickets), isActive: $goHome){
                                    Button(action: {
                                        print("티켓 수정 버튼 클릭")
                                        showingAlert = true
                                        checkInfo()
                                    }) {
                                        Text("티켓 수정")
                                            .font(.system(size: 13))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(width: 120, height: 50)
                                    .background(Color("HolicBlue"))
                                    .cornerRadius(15)
                                    .alert(isPresented: $showingAlert) {
                                        Alert(
                                            title: Text(editAble ? "수정 완료!" : "필수 항목을 작성해주세요!"),
                                            message: nil,
                                            dismissButton: .default(Text("확인"), action: {
                                                if editAble {
                                                    isLoading = true
                                                    editTicket()
                                                }
                                                else{
                                                    showingAlert = false
                                                }
                                            })
                                        )
                                    }
//                                }
                                
                                .fullScreenCover(isPresented: $goHome, content: {
                                    ContentView(tickets: tickets)
                                })
                                
                                Button(action: {
                                    showingDeleteAlert = true
                                }) {
                                    Text("티켓 삭제")
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color("HolicGray"))
                                .cornerRadius(15)
                                .alert(isPresented: $showingDeleteAlert) {
                                    Alert(
                                        title: Text("티켓 삭제"),
                                        message: Text("해당 티켓을 삭제하시겠습니까?"),
                                        primaryButton: .default(Text("확인"), action: {
                                            isLoading = true
                                            deleteTicket()
                                        }),
                                        secondaryButton: .cancel(Text("취소"))
                                    )
                                }
                                
                            } //HStack
                            .padding(EdgeInsets(top: 48, leading: 71, bottom: 0, trailing: 71))
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
                                        targetTicket.date = dateFormatter.string(from: schedule)
                                        isDatePickerVisible.toggle()
                                    }) {
                                        Text("Done")
                                            .font(.system(size: 13))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(width: 100, height: 40)
                                    .background(Color("HolicBlue"))
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
                
            } //VStack
            .onAppear {
                if !findTicket {
                    for ticket in tickets {
                        if ticket._id == ticketId.idIndex {
                            targetTicket = ticket
                            break  // 일치하는 항목을 찾았으므로 루프 종료
                        }
                    }
                }
            }
        }
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
    
    private func checkInfo(){
        guard !targetTicket.concert.isEmpty, !targetTicket.date.isEmpty, !targetTicket.address.isEmpty else {
            print("공연명, 일시, 장소는 필수 입력 사항입니다.")
            return
        }
        
        editAble = true
    }
    
    private func editTicket() {
        guard !targetTicket.concert.isEmpty, !targetTicket.date.isEmpty, !targetTicket.address.isEmpty else {
            print("공연명, 일시, 장소는 필수 입력 사항입니다.")
            showingAlert = true
            return
        }
        
        if targetTicket.seat.isEmpty {
            self.targetTicket.seat = "정보없음"
        }
        
        TicketManager.shared.editTicket(uuid: user.uuid, _id: targetTicket._id, concert: targetTicket.concert, address: targetTicket.address, date: targetTicket.date, seat: targetTicket.seat, img: targetTicket.img){
            success in
            TicketManager.shared.getTicket(uuid: user.uuid, tickets: $tickets){ success in
                isLoading = false
                goHome = true
            }
        }
        
        print("티켓 수정 완료!")

    }
    
    private func deleteTicket() {
        // 배열에서 티켓을 제거합니다.
        TicketManager.shared.deleteTicket(ticketId: ticketId.idIndex){
            success in
            TicketManager.shared.getTicket(uuid: user.uuid, tickets: $tickets){ success in
                isLoading = false
            }
        }
        
        print("티켓 삭제 완료!")
        

    }
}
//
//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTicketView(isEditing: .constant(false), tickets: .constant([]), targetTicket:         TicketDataModel(
//            uuid: "",
//            _id: -1,
//            concert: "오페라의 유령",
//            address: "으아아dkdkdkdkdkdkdkdkdk",
//            date: "2023.09.20 11시 20분",
//            seat: "String",
//            posX: "String",
//            posY: "String",
//            img: "img"
//        ), isLoading: .constant(false))
//    }
//}
