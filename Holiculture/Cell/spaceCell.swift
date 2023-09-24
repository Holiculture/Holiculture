//
//  spaceCell.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/21.
//

import SwiftUI

struct SpaceCell: View {
    
    @State var stateOfHeart = "heart"
    
    @Binding var place: PlaceDataModel
    
//    @State var place: PlaceDataModel
    var concert: TicketDataModel
    
    @EnvironmentObject var user: uuidVM
    @State var isError = false
    
    
    var body: some View {
        VStack{
            GrayLine()
            Button(action: {
                print("추천 장소 클릭")
            }) {
                HStack(spacing: 0){
                    Spacer()
                    VStack{
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 90, height: 120)
                            .background(
                                AsyncImage(url: URL(string: place.img.isEmpty ? "" : place.img)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 120)
                                            .clipped()
                                    case .failure(let error):
                                        Image("image1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 120)
                                            .clipped()
                                    }
                                }
                            )
                            .cornerRadius(10)
                            .padding(.trailing, 16)
                        Spacer()
                    }
                    
                    VStack{
                        Spacer()
                        VStack{
                            HStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 2, height: 15)
                                    .background(Color("HolicBlue"))
                                
                                Text(place.place_name)
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("HolicGray"))
                                
                                
                                Text(place.category_name)
                                    .font(.system(size: 10))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                
                                Spacer()
                                
                                Button(action: {
                                    print("좋아요 클릭")
                                    place.isLike.toggle()
                                    if place.isLike {
                                        LikeManager.shared.sendLike(uuid: user.uuid, placeData: place)
                                    }
                                    else{
                                        LikeManager.shared.deleteLike(uuid: user.uuid, address: place.road_address_name) //작동이 안됨
                                    }
                                    stateOfHeart = place.isLike ? "heart.fill" : "heart"
                                }) {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 12, height: 12)
                                        .background(
                                            Image(systemName: place.isLike ? "heart.fill" : "heart")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 12, height: 12)
                                            // MARK: - 나중에 어플 색상으로 변경하기
                                                .foregroundColor(place.isLike ? Color("HolicBlue") : Color(red: 0.58, green: 0.58, blue: 0.58))
                                        )
                                }
                            }
                            .frame(width: 230, height: 18)
                            .minimumScaleFactor(0.6)
                            
                            HStack{
                                Text("공연장과의 거리 \(place.distance)m")
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("HolicGray"))
                                Spacer()
                            }
                            .frame(width: 230, height: 10)
                        }
                        
                        
                        Spacer()
                        
                        HStack{
                            Button(action: {
                                print("리뷰 클릭")
                                
                                let encodedURL = place.place_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                
                                
                                if let url = URL(string: encodedURL) {
                                    UIApplication.shared.open(url)
                                }
                                
                                
                            }) {
                                Text("자세히 보기")
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("HolicGray"))
                            }
                            .padding()
                            .frame(width: 110, height: 35)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            
                            
                            Button(action: {
                                print("길찾기 클릭")
                                
                                let urlString = "kakaomap://route?sp=\(concert.posY),\(concert.posX)&ep=\(place.y),\(place.x)&by=FOOT"
                                print(urlString)
                                
                                if let url = URL(string: urlString) {
                                    if UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url) { success in
                                            if success {
                                                // URL을 성공적으로 여는 경우
                                            } else {
                                                // URL을 여는 중에 오류 발생
                                                let safariURL = "https://map.kakao.com/link/to/\(place.place_name),\(place.y),\(place.x)"
                                                let encodedURL = safariURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                                
                                                if let url = URL(string: encodedURL) {
                                                    UIApplication.shared.open(url)
                                                }
//                                                isError = true
                                            }
                                        }
                                    } else {
                                        // 해당 URL을 열 수 없는 경우
                                        let safariURL = "https://map.kakao.com/link/to/\(place.place_name),\(place.y),\(place.x)"
                                        let encodedURL = safariURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                        
                                        if let url = URL(string: encodedURL) {
                                            UIApplication.shared.open(url)
                                        }
//                                        isError = true
                                    }
                                } else {
                                    // 올바르지 않은 URL
                                    let safariURL = "https://map.kakao.com/link/to/\(place.place_name),\(place.y),\(place.x)"
                                    let encodedURL = safariURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                    
                                    if let url = URL(string: encodedURL) {
                                        UIApplication.shared.open(url)
                                    }
//                                    isError = true
                                }
                                
                            }) {
                                Text("길찾기")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("HolicGray"))
                                
                            }
                            .padding()
                            .frame(width: 110, height: 35)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
//                            .alert(isPresented: $isError) {
//                                Alert(
//                                    title: Text("실행 오류"),
//                                    message: Text("카카오맵을 다운로드 해주세요!"),
//                                    primaryButton: .default(Text("다운로드 하기"), action: {
//                                        isError = false
//
//                                        if let appStoreURL = URL(string: "https://apps.apple.com/kr/app/apple-store/id304608425") {
//                                            UIApplication.shared.open(appStoreURL)
//                                        }
//                                    }),
//                                    secondaryButton: .destructive(Text("취소"))
//                                )
//                            }
                        }
                        
                        Spacer()
                    } //HStack
                    Spacer()
                }//VStack
                
//
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 90, height: 110)
//                    .background(
//                        AsyncImage(url: URL(string: place.img.isEmpty ? "" : place.img)) { phase in
//                            switch phase {
//                            case .empty:
//                                ProgressView()
//                            case .success(let image):
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 110, height: 110)
//                                    .clipped()
//                            case .failure(let error):
//                                Image("image1")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 110, height: 110)
//                                    .clipped()
//                            }
//                        }
//                    )
//                    .cornerRadius(5)
//                    .padding(.leading, 10)
//
                
                Spacer()
                
            }
            
            
        }//HStack
        .frame(width: 353, height: 130)
        .background(.white)
    }
}//VStack


//
//struct SpaceCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SpaceCell(place: PlaceDataModel(place_name: "오코노미야키식당하나",
//                                        place_url: "http://place.map.kakao.com/1441425449",
//                                        category_name: "오코노미야끼",
//                                        distance: "284",
//                                        road_address_name: "서울 광진구 능동로13길 111",
//                                        //                                        cate: "식당",
//                                        img: "https://k.kakaocdn.net/dn/MqMFj/btrCs36javK/mKeWImMBElB4sCZvvQRJUK/img.jpg", isLike: false,
//                                        x: "0.1",
//                                        y: "0.2"
//
//                                       ), concert: TicketDataModel(
//                                        uuid: "",
//                                        _id: -1,
//                                        concert: "",
//                                        address: "",
//                                        date: "",
//                                        seat: "",
//                                        posX: "",
//                                        posY: ""
//                                       )
//        )
//    }
//}
