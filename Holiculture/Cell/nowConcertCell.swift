//
//  SwiftUIView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/21.
//

import SwiftUI

struct nowConcertCell: View {
    
   
    @State var concert = ConcertDataModel(_id: 1188,
                                                         title: "벤허",
                                                         startDate: "20230902",
                                                         endDate: "20231119",
                                                         titleImg: "https://www.kopis.or.kr/upload/pfmPoster/PF_PF222520_230721_125651.gif",
                                                         location: "LG아트센터 서울",
                                                         cate: "뮤지컬",
                                                         address: "서울특별시 강서구 마곡중앙로 136(마곡동)",
                                                         summary: " ",
                                                         cast: "박은태, 신성록, 이지훈, 박민성, 서경수, 이정화, 최지혜 등",
                                                         crew: " ",
                                                         runtime: "2시간 35분",
                                                         age: "만 7세 이상",
                                                         producer: "(주)EMK뮤지컬컴퍼니",
                                                         price: "VIP석 170,000원, R석 140,000원, S석 110,000원, A석 80,000원",
                                                         time: "화요일(19:30), 수요일(14:30,19:30), 목요일(19:30), 금요일(14:30,19:30), 토요일(14:00,19:00), 일요일(15:00), HOL(14:00,19:00)",
                                                         openrun: "N",
                                                         subImgs: [
                                                             "https://www.kopis.or.kr/upload/pfmIntroImage/PF_PF222520_230721_1256510.jpg"
                                                         ])
    @State var isActive = false
    var body: some View {
        NavigationLink(destination : ConcertInfo2(concert: concert), isActive: $isActive){
            Button(action: {
                isActive = true
                print("등록하기 버튼 클릭")
            }) {
                VStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 100, height: 124)
                        .background(
                            AsyncImage(url: URL(string: concert.titleImg)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                    //                            Image("image1") // ticket.img가 비어 있을 때 기본 이미지로 설정
                                    //                                .resizable()
                                    //                                .aspectRatio(contentMode: .fill)
                                    //                                .frame(width: 100, height: 124)
                                    //                                .clipped()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 124)
                                        .clipped()
                                case .failure(let error):
                                    Image("image1") // 이미지 로드 실패 시 기본 이미지로 설정
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 124)
                                        .clipped()
                                }
                            }
                        )
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: 1)
                        )
                        .padding(.bottom, 5)
                    
                    VStack(spacing: 2){
                        Text("\(concert.title)")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        
                        
                        Text("\(concert.location)")
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                        
                        if let startDate = formatDate(inputString: concert.startDate), let endDate = formatDate(inputString: concert.endDate) {
                            Text("\(startDate) ~ \(endDate)")
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        } else {
                            Text("\(concert.startDate) ~ \(concert.endDate)") // 날짜 형식이 올바르지 않을 경우 처리
                        }
                    }
                    .foregroundColor(Color("HolicGray"))
                    
                }
                .frame(maxWidth: 100)
                .padding(.bottom, 10)
            
            }
        }
//            VStack{
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 124)
//                    .background(
//                        AsyncImage(url: URL(string: concert.titleImg)) { phase in
//                            switch phase {
//                            case .empty:
//                                ProgressView()
//                                //                            Image("image1") // ticket.img가 비어 있을 때 기본 이미지로 설정
//                                //                                .resizable()
//                                //                                .aspectRatio(contentMode: .fill)
//                                //                                .frame(width: 100, height: 124)
//                                //                                .clipped()
//                            case .success(let image):
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 100, height: 124)
//                                    .clipped()
//                            case .failure(let error):
//                                Image("image1") // 이미지 로드 실패 시 기본 이미지로 설정
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 100, height: 124)
//                                    .clipped()
//                            }
//                        }
//                    )
//                    .cornerRadius(10)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .inset(by: 0.5)
//                            .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: 1)
//                    )
//                    .padding(.bottom, 5)
//
//                VStack(spacing: 2){
//                    Text("\(concert.title)")
//                        .font(.system(size: 12))
//                        .fontWeight(.semibold)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.8)
//
//
//                    Text("\(concert.location)")
//                        .font(.system(size: 10))
//                        .fontWeight(.semibold)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.6)
//
//                    if let startDate = formatDate(inputString: concert.startDate), let endDate = formatDate(inputString: concert.endDate) {
//                        Text("\(startDate) ~ \(endDate)")
//                            .font(.system(size: 10))
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//                            .minimumScaleFactor(0.6)
//                    } else {
//                        Text("\(concert.startDate) ~ \(concert.endDate)") // 날짜 형식이 올바르지 않을 경우 처리
//                    }
//                }
//
//            }
//            .frame(maxWidth: 100)
//            .padding(.bottom, 10)
//
    }
    
    func formatDate(inputString: String) -> String? {
        // 문자열의 길이가 충분히 길어야 합니다 (예: "230904"의 경우 최소 6자여야 합니다).
        guard inputString.count >= 6 else {
            return nil
        }
        
        // 연도, 월, 일 부분을 추출합니다.
        let year = inputString.dropFirst(2).prefix(2)
        let month = inputString.dropFirst(4).prefix(2)
        let day = inputString.dropFirst(6).suffix(2)
        
        // "년월일" 형식으로 조합합니다.
        let formattedString = "\(year)년\(month)월\(day)일"
        
        return formattedString
    }

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        nowConcertCell()
    }
}
