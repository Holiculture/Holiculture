//
//  likeCell.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/21.
//

import SwiftUI


struct likeCell: View {
    
    @Binding var like: LikeDataModel
    @EnvironmentObject var user: uuidVM
    
    @State var isStart: Bool = false
    @State var isFinish: Bool = false

    @Binding var isStartOn: Bool
    @Binding var isFinishOn: Bool
    @Binding var start: String
    @Binding var finish: String
    
    @Binding var likes: [LikeDataModel]
    
    @Binding var isLoading: Bool
    
    @Binding var startLike: LikeDataModel
    @Binding var finishLike: LikeDataModel
  
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 340, height: 1)
                .background(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4))
            
            HStack{
                // MARK: - 좋아요 버튼
                Button(action: {
                    print("좋아요 클릭")
                    like.isLike.toggle()
                    if like.isLike {
                        LikeManager.shared.sendIsLike(uuid: user.uuid, placeData: like)
                    }
                    else{
                        isLoading = true
                        LikeManager.shared.deleteLike(uuid: user.uuid, address: like.road_address_name)
                        LikeManager.shared.getLike(uuid: user.uuid, likes: $likes){ success in
                            isLoading = false
                        }
                    }
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 12, height: 12)
                        .background(
                            Image(systemName: like.isLike ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 12, height: 12)
                                .foregroundColor(Color("HolicBlue"))
                        )
                }
                
                HStack{
                    Text(like.place_name)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    
                    
                    Text(like.category_name)
                        .font(.system(size: 10))
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .frame(width: 155, height: 15)
                .minimumScaleFactor(0.3)
                
                HStack{
                    Spacer()
                    Button(action: {
                        print("출발 클릭")

                        start = "\(like.place_name)"
                        startLike = like
                        print("\(startLike.place_name)")
                    }) {
                        Text("출발")
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .foregroundColor(isStart ? Color(.white) : Color("HolicGray"))
                    }
                    .frame(width: 55, height: 35)
                    .background(isStart ? Color("HolicGray") : Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("HolicGray"), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    
                    
                    Button(action: {
                        print("도착 클릭")

                        finish = "\(like.place_name)"
                        finishLike = like
                        print("\(finishLike.place_name)")
                    }) {
                        Text("도착")
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .foregroundColor(isFinish ? Color(.white) : Color("HolicGray"))
                    }
                    .frame(width: 55, height: 35)
                    .background(isFinish ? Color("HolicGray") : Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("HolicGray"), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    
                }
                
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
        }
    }
}

//
//struct LikeCell_Previews: PreviewProvider {
//    static var previews: some View {
//        likeCell(like: .constant(LikeDataModel(uuid: "0DF1E963-22AD-4A6C-88A0-2CC25A71CB19", _id: 39,
//                                     place_name: "https:/ADFADFADFADFADFADSFADFADFADDAFADF",
//                                     place_url: "삼겹살",
//                                     category_name: "httadp",
//                                     distance: "286",
//                                     road_address_name: "서울 광진구 능동로19길 36",
//                                     img: "깍뚝",
//                                               isLike: true, x: "", y: "")), isStart: false, isFinish: false, isStartOn: .constant(false), isFinishOn: .constant(false), start: .constant(""), finish: .constant(""), likes: .constant([]), isLoading: .constant(false), startLike: .constant(LikeDataModel(uuid: "0DF1E963-22AD-4A6C-88A0-2CC25A71CB19", _id: 39,
//                                                                                                                                                                                                                                                                                                            place_name: "https:/ADFADFADFADFADFADSFADFADFADDAFADF",
//                                                                                                                                                                                                                                                                                                            place_url: "삼겹살",
//                                                                                                                                                                                                                                                                                                            category_name: "httadp",
//                                                                                                                                                                                                                                                                                                            distance: "286",
//                                                                                                                                                                                                                                                                                                            road_address_name: "서울 광진구 능동로19길 36",
//                                                                                                                                                                                                                                                                                                            img: "깍뚝",
//                                                                                                                                                                                                                                                                                                                      isLike: true, x: "", y: "")), finishLike: .constant(LikeDataModel(uuid: "0DF1E963-22AD-4A6C-88A0-2CC25A71CB19", _id: 39,
//                                                                                                                                                                                                                                                                                                                                                                                        place_name: "https:/ADFADFADFADFADFADSFADFADFADDAFADF",
//                                                                                                                                                                                                                                                                                                                                                                                        place_url: "삼겹살",
//                                                                                                                                                                                                                                                                                                                                                                                        category_name: "httadp",
//                                                                                                                                                                                                                                                                                                                                                                                        distance: "286",
//                                                                                                                                                                                                                                                                                                                                                                                        road_address_name: "서울 광진구 능동로19길 36",
//                                                                                                                                                                                                                                                                                                                                                                                        img: "깍뚝",
//                                                                                                                                                                                                                                                                                                                                                                                                  isLike: true, x: "", y: "")))
//    }
//}
