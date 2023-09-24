//
//  WishView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/15.
//

import SwiftUI
import Combine

struct WishView: View {
    
    @State var start: String = ""
    @State var finish: String = ""
    @State var isActive: Bool = false
    @State var urlString: String = ""
    @State var isError: Bool = false
    
    @Binding var tickets: [TicketDataModel]
    @Binding var likes: [LikeDataModel]
    @EnvironmentObject var user: uuidVM
    
    @State var isStartOn: Bool = false
    @State var isFinishOn: Bool = false
    
    @State var isLoading: Bool = true
    
    @State var startLike: LikeDataModel
    @State var finishLike: LikeDataModel
    
    func swapLocations() {
        let temp = start
        start = finish
        finish = temp
    }
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 4){
                ZStack{
                    Rectangle()
                        .background(Color(uiColor: .white))
                        .frame(width: 280, height: 70)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: 1)
                        )
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 270, height: 1)
                        .background(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4))
                    
                    VStack(spacing: 2){
                        TextField("출발지", text: $start)
                            .disabled(true)
                            .font(.system(size: 12))
                            .padding()
                            .frame(width: 280, height: 34)
                            .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                            .minimumScaleFactor(0.5)
                            .cornerRadius(10)
                            .foregroundColor(Color("HolicGray"))
                        
                        TextField("도착지", text: $finish)
                            .disabled(true)
                            .font(.system(size: 12))
                            .padding()
                            .frame(width: 280, height: 34)
                            .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                            .minimumScaleFactor(0.5)
                            .cornerRadius(10)
                            .foregroundColor(Color("HolicGray"))
                    }
                }
                
                
                VStack(spacing: 2){
                    HStack(spacing: 1){
                        Button(action: {
                            print("전환 클릭")
                            swapLocations()
                        }) {
                            Text("⇅")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 27, height: 35)
                        .background(Color("HolicBlue"))
                        //                        .overlay(
                        //                            RoundedRectangle(cornerRadius: 10)
                        //                                .stroke(Color("HolicGray"), lineWidth: 2)
                        //                        )
                        .cornerRadius(10)
                        
                        Button(action: {
                            print("삭제 클릭")
                            start = ""
                            finish = ""
                        }) {
                            Text("✕")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 27, height: 35)
                        .background(Color("HolicBlue"))
                        //                        .overlay(
                        //                            RoundedRectangle(cornerRadius: 10)
                        //                                .stroke(Color("HolicGray"), lineWidth: 2)
                        //                        )
                        .cornerRadius(10)
                    }
                    
                    
                    Button(action: {
                        print("길찾기 클릭")
                        if isActive {
                            let urlString = "kakaomap://route?sp=\(startLike.y),\(startLike.x)&ep=\(finishLike.y),\(finishLike.x)&by=FOOT"
                            
                            print(urlString)
                            
                            if let url = URL(string: urlString) {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url) { success in
                                        if success {
                                            // URL을 성공적으로 여는 경우
                                        } else {
                                            // URL을 여는 중에 오류 발생
                                            let appleMapURL = "http://maps.apple.com/?saddr=\(startLike.road_address_name)&daddr=\(finishLike.road_address_name)&dirflg=w"
                                            let encodedURL = appleMapURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                            
                                            if let url = URL(string: encodedURL) {
                                                UIApplication.shared.open(url)
                                            }
                                        }
                                    }
                                } else {
                                    // 해당 URL을 열 수 없는 경우
                                    let appleMapURL = "http://maps.apple.com/?saddr=\(startLike.road_address_name)&daddr=\(finishLike.road_address_name)&dirflg=w"
                                    let encodedURL = appleMapURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                    
                                    if let url = URL(string: encodedURL) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            } else {
                                // 올바르지 않은 URL
                                let appleMapURL = "http://maps.apple.com/?saddr=\(startLike.road_address_name)&daddr=\(finishLike.road_address_name)&dirflg=w"
                                let encodedURL = appleMapURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                
                                if let url = URL(string: encodedURL) {
                                    UIApplication.shared.open(url)
                                }
                            }
 
                        }
                    }) {
                        Text("길찾기")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .foregroundColor(isActive ? Color(.white) : Color("HolicGray"))
                        
                    }
                    .frame(width: 55, height: 35)
                    .background(isActive ? Color("HolicBlue") : Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.83, green: 0.83, blue: 0.83), lineWidth: isActive ? 0 : 2)
                    )
                    .cornerRadius(10)
                    //                    .alert(isPresented: $isError) {
                    //                        Alert(
                    //                            title: Text("실행 오류"),
                    //                            message: Text("카카오맵을 다운로드 해주세요!"),
                    //                            primaryButton: .default(Text("다운로드 하기"), action: {
                    //                                isError = false
                    //
                    //                                if let appStoreURL = URL(string: "https://apps.apple.com/kr/app/apple-store/id304608425") {
                    //                                 UIApplication.shared.open(appStoreURL)
                    //                                }
                    //                            }),
                    //                            secondaryButton: .destructive(Text("취소"))
                    //                        )
                    //                    }
                }
            }
            .onReceive(Just(start)) { newValue in
                isActive = !(start.isEmpty || finish.isEmpty)
            }
            .onReceive(Just(finish)) { newValue in
                isActive = !(start.isEmpty || finish.isEmpty)
            }
            
            Spacer()
            
            
            ScrollView{
                if isLoading{
                    ProgressView()
                        .tint(Color("HolicBlue"))
                        .padding(.top,300)
                }
                else{
                    if(tickets.isEmpty){
                        Text("🎫")
                            .font(.system(size: 90))
                            .padding(.top, 180)
                            .padding(.bottom, 3)
                        
                        Text("티켓 등록을 먼저 해주세요!")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color("HolicGray"))
                    }
                    else{
                        ForEach($tickets, id: \._id) { ticket in
                            concertCell(concert: ticket, isStartOn: $isStartOn, isFinishOn: $isFinishOn, start: $start, finish: $finish, startLike: $startLike, finishLike: $finishLike)
                        }
                        ForEach($likes, id: \.place_name) { like in
                            likeCell(like: like, isStartOn: $isStartOn, isFinishOn: $isFinishOn, start: $start, finish: $finish, likes: $likes, isLoading: $isLoading, startLike: $startLike, finishLike: $finishLike)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }//ScrollView
        }
        .padding(.top, 15)
        .onAppear{
            self.isLoading = true
            LikeManager.shared.getLike(uuid: user.uuid, likes: $likes){ success in
                self.isLoading = false
            }
            
            start = ""
            finish = ""
            
            print("전체 좋아요 목록:")
            for like in likes {
                print(like.place_name)
            }
        }
    }
    
}





//struct WishView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishView()
//    }
//}
