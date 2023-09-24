//
//  SwiftUIView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/03.
//

import SwiftUI

struct DateInputView: View {
    @State private var isDatePickerVisible = false
    @State var date: String = ""
    @State var concert: String = ""
    @State private var schedule = Date()
    @State var isActive = false
    @State var backHome = false
    @State var dateEmpty = false
    
    @Binding var tickets: [TicketDataModel]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 20){
                    Text("공연 일시를 입력해주세요")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
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
                            .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 0, leading: 27, bottom: 0, trailing: 23))
                    
                    HStack{
                        NavigationLink(destination: ConcertSearchView(tickets: $tickets, date: $date), isActive: $isActive){
                            Button(action: {
                                print("다음 버튼 클릭")
                                if date.isEmpty {
                                    dateEmpty = true
                                }
                                else{
                                    isActive = true
                                }
                            }) {
                                Text("다음")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color("HolicBlue"))
                            .cornerRadius(15)
                            .alert(isPresented: $dateEmpty) {
                                let alert = Alert(
                                    title: Text("일시를 등록해주세요!"),
                                    message: nil,
                                    dismissButton: .default(Text("확인"), action: {
                                        dateEmpty = false
                                    })
                                )
                                return alert
                            }
//                            .fullScreenCover(isPresented: $isActive, content: {
//                                ConcertSearchView(tickets: $tickets, date: $date)
//                            })
                        }
                    }
                    
                }
                .padding(EdgeInsets(top: 14, leading: 71, bottom: 0, trailing: 71))
                
                
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
                            .background(Color("HolicBlue"))
                            .cornerRadius(15)
                            .padding(.bottom, 5)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                    }
                    .frame(width: 360, height: 500)
                    .background(Color.white)
                    .cornerRadius(30)
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
}


struct DateInputView_Previews: PreviewProvider {
    static var previews: some View {
        DateInputView(tickets: .constant([]))
    }
}
