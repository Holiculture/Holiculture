//
//  NowConcertView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/21.
//

import SwiftUI

struct NowConcertView: View {
    
    @State var concerts: [ConcertDataModel] = []
    @State var isLoading = true
//    @State var date = "2023.09.23 11시 20분"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd hh시 mm분"
        return formatter
    }()

    var formattedCurrentDateTime: String {
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
//        NavigationStack{
            VStack{
                HStack{
                    Text("현재 상영중인 공연")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .foregroundColor(Color("HolicGray"))
                        .padding(.top, 15)
                    Spacer()
                        Text("\(formattedCurrentDateTime) 기준")
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .padding(.top, 23)
                }
                .padding(.horizontal, 20)
                if isLoading {
                    ProgressView()
                        .tint(Color("HolicBlue"))
                        .frame(maxHeight: .infinity)
                }
                else{
                    ScrollView{
                        cateConcertList(cate: "뮤지컬", concerts: concerts)
                        cateConcertList(cate: "대중음악", concerts: concerts)
                        cateConcertList(cate: "연극", concerts: concerts)
                        cateConcertList(cate: "서커스/마술", concerts: concerts)
                        cateConcertList(cate: "무용", concerts: concerts)
                        cateConcertList(cate: "클래식", concerts: concerts)
                        cateConcertList(cate: "국악", concerts: concerts)
                        cateConcertList(cate: "복합", concerts: concerts)
                        
                    }
                }
            }
//        }
        .onAppear{
            ConcertManager.shared.getConcertList(concerts: $concerts, date: formattedCurrentDateTime){ success in
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
}

struct NowConcertView_Previews: PreviewProvider {
    static var previews: some View {
//         ContentView()
        NowConcertView()
    }
}
