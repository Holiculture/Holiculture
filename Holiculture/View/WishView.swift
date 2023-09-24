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
                                .stroke(Color("HolicGray"), lineWidth: 1)
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
                            .cornerRadius(10)
                            .foregroundColor(Color("HolicGray"))
                        
                        TextField("도착지", text: $finish)
                            .disabled(true)
                            .font(.system(size: 12))
                            .padding()
                            .frame(width: 280, height: 34)
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
                        .background(Color("HolicGray"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("HolicGray"), lineWidth: 2)
                        )
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
                        .background(Color("HolicGray"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("HolicGray"), lineWidth: 2)
                        )
                        .cornerRadius(10)
                    }
                    
                    
                    Button(action: {
                        print("길찾기 클릭")
                        if isActive {
                            let startNameEncoded = startLike.place_name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            let finishNameEncoded = finishLike.place_name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            
                            let urlString = "http://m.map.naver.com/route.nhn?menu=route&sname=\(startNameEncoded)&sx=\(startLike.x)&sy=\(startLike.y)&ename=\(finishNameEncoded)&ex=\(finishLike.x)&ey=\(finishLike.y)&pathType=0&showMap=true"
                            
                            print(urlString)
                            
                            if let url = URL(string: urlString) {
                                UIApplication.shared.open(url)
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
                    .background(isActive ? Color("HolicGray") : Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("HolicGray"), lineWidth: 2)
                    )
                    .cornerRadius(10)
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
                        .padding(.top,300)
                }
                else{
                    if(likes.isEmpty){
                        Text("💔")
                            .font(.system(size: 90))
                            .padding(.top, 180)
                            .padding(.bottom, 3)
                        
                        Text("좋아요 내역이 없습니다!")
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
