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
    
    @EnvironmentObject var user: uuidVM

    
    var body: some View {
        VStack{
            GrayLine()
            Button(action: {
                print("추천 장소 클릭")
            }) {
                HStack(spacing: 0){
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
                    
                    VStack{
                        Spacer()
                        HStack{
                            VStack{
                                HStack{
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
                                                    .foregroundColor(.black)
                                            )
                                    }
                                    HStack{
                                        Text(place.place_name)
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        
                                            .foregroundColor(Color("HolicGray"))
                                        
                                        
                                        Text(place.category_name)
                                            .font(.system(size: 10))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                        
                                        Spacer()
                                    }
                                    .frame(width: 200, height: 20)
                                    .minimumScaleFactor(0.6)
                                    .padding(.bottom, 2)
                                    Spacer()
                                }
 
                                HStack{
                                    Text("공연장과의 거리 \(place.distance)m")
                                        .font(.system(size: 10))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("HolicGray"))
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack{
                            Button(action: {
                                print("리뷰 클릭")
                                if let url = URL(string: place.place_url) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Text("🔎 자세히 보기")
                                    .font(.system(size: 9))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("HolicGray"))
                            }
                            .padding()
                            .frame(width: 110, height: 35)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("HolicGray"), lineWidth: 2)
                            )
                            .cornerRadius(10)
                            
                            
                            Button(action: {
                                print("길찾기 클릭")
                            }) {
                                Text("📍길찾기")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 9))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("HolicGray"))
                                
                            }
                            .padding()
                            .frame(width: 110, height: 35)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("HolicGray"), lineWidth: 2)
                            )
                            .cornerRadius(10)
                            
                            Spacer()
                        } //HStack
                        Spacer()
                    }//VStack
                    Spacer()
                }//HStack
                .frame(width: 353, height: 130)
                .background(.white)
            }
        }//VStack
    }
}

//struct SpaceCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SpaceCell(place: PlaceDataModel(place_name: "오코노미야키식당하나",
//                                        place_url: "http://place.map.kakao.com/1441425449",
//                                        category_name: "오코노미야끼",
//                                        distance: "284",
//                                        road_address_name: "서울 광진구 능동로13길 111",
//                                        cate: "식당",
//                                        img: "https://k.kakaocdn.net/dn/MqMFj/btrCs36javK/mKeWImMBElB4sCZvvQRJUK/img.jpg", isLike: false
//
//                                       ))
//    }
//}
