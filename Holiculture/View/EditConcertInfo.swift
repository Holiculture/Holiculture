//
//  EditConcertInfo.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/21.
//

import SwiftUI

struct EditConcertInfo: View {
    
    @Binding var tickets: [TicketDataModel]
    @State var targetTicket: TicketDataModel
    @Binding var isLoading: Bool
    @State var concert: ConcertDataModel

    @State var isActive: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 2, height: 15)
                        .background(Color("HolicBlue"))
                    
                    HStack{
                        Text("\(concert.title)")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("\(concert.cate)")
                            .font(.system(size: 10))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    
                }
                
                ScrollView{
                    
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 255, height: 317)
                    .background(
                        AsyncImage(url: URL(string: concert.titleImg)) { phase in
                            switch phase {
                            case .empty:
                                Image("image1") // ticket.img가 비어 있을 때 기본 이미지로 설정
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 255, height: 317)
                                    .clipped()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 255, height: 317)
                                    .clipped()
                            case .failure(let error):
                                Image("image1") // 이미지 로드 실패 시 기본 이미지로 설정
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 255, height: 317)
                                    .clipped()
                            }
                        }
                    )
                    .cornerRadius(0)
                
                
                    
                    concertInfoCell(option: "공연기간", optionData: "\(concert.startDate) ~ \(concert.endDate)")
                    concertInfoCell(option: "공연장소", optionData: "\(concert.location)")
                    concertInfoCell(option: "공연시간", optionData: "\(concert.time)")
                    concertInfoCell(option: "관람연령", optionData: "\(concert.age)")
                    concertInfoCell(option: "티켓가격", optionData: "\(concert.price)")
                    concertInfoCell(option: "출연진", optionData: "\(concert.cast)")
                    concertInfoCell(option: "제작진", optionData: "\(concert.crew)")
                    concertInfoCell(option: "상영시간", optionData: "\(concert.runtime)")
                        .padding(.bottom, 15)
                    
                    NavigationLink(destination : EditTicketView(isEditing: $isActive, tickets: $tickets, targetTicket: TicketDataModel(uuid: targetTicket.uuid, _id: targetTicket._id, concert: concert.title, address: concert.address, date: targetTicket.date, seat: targetTicket.seat, posX: "", posY: "", img: concert.titleImg), isLoading: $isLoading, findTicket: true)) {
                        Button(action: {
                            isActive = true
                            print("등록하기 버튼 클릭")
                        }) {
                            Text("등록하기")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 120, height: 50)
                        .background(Color("HolicBlue"))
                        .cornerRadius(15)
                        .padding(.bottom, 20)
                    }
                    
                    
                }
                
                
            }
            .padding(.horizontal, 30)
            .frame(maxHeight: .infinity)
            .background(.white)
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

struct EditConcertInfo_Previews: PreviewProvider {
    static var previews: some View {
        ConcertInfo(tickets:.constant([]), date: .constant(""), concert: ConcertDataModel(_id: 748, title: "제6회 1번출구 연극제", startDate: "20230920", endDate: "20231029", titleImg: "https://www.kopis.or.kr/upload/pfmPoster/PF_PF224355_230822_105515.gif", location: "한성아트홀(구. 인켈아트홀)", cate: "연극", address: "서울특별시 종로구 창경궁로 254 (명륜2가)", summary: " ", cast: "모형주, 안병준, 이혜림, 권혁재, 노윤서, 이종민, 황선영 등", crew: "정범철, 박혜선, 최해주 등", runtime: "1시간 30분", age: "만 15세 이상", producer: " ", price: "전석 30,000원", time: "수요일 ~ 금요일(19:30), 토요일 ~ 일요일(15:00)", openrun: "N", subImgs: ["https://www.kopis.or.kr/upload/pfmIntroImage/PF_PF224355_230822_1055150.jpg",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               "https://www.kopis.or.kr/upload/pfmIntroImage/PF_PF224355_230822_1055150.jpg",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               "https://www.kopis.or.kr/upload/pfmIntroImage/PF_PF224355_230822_1055150.jpg"]))
    }
}
