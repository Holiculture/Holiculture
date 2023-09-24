//
//  concertCell.swift
//  Holiculture
//
//  Created by 민지은 on 2023/08/29.
//

import SwiftUI


struct concertCell: View {
           
    @Binding var concert: TicketDataModel
    
    @State var isStart: Bool = false
    @State var isFinish: Bool = false

    @Binding var isStartOn: Bool
    @Binding var isFinishOn: Bool
    
    @Binding var start: String
    @Binding var finish: String

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

                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 10, height: 10)
                    .background(
                        Image(systemName: "pin.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.black)
                    )

                
                HStack{
                    Text("\(concert.concert)_\(concert.address)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)

                    Spacer()
                }
                .frame(width: 155, height: 15)
                .minimumScaleFactor(0.3)
                
                HStack{
                    Spacer()
                    Button(action: {
                        print("출발 클릭")

                        start = "\(concert.address)"
                        startLike = LikeDataModel(uuid: concert.uuid,
                                                  _id: concert._id,
                                                  place_name: concert.concert,
                                                  place_url: "",
                                                  category_name: "",
                                                  distance: "",
                                                  road_address_name: concert.address,
                                                  cate: "",
                                                  img: "",
                                                  isLike: false,
                                                  x: concert.posX,
                                                  y: concert.posY)
                        
                        print("\(startLike.place_name)")
                    }) {
                        Text("🚶출발")
                            .font(.system(size: 8.5))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("HolicGray"))
                    }
                    .frame(width: 55, height: 30)
                    .background(Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color("HolicGray"), lineWidth: 2)
                    )
                    .cornerRadius(7)
                    
                    
                    Button(action: {
                        print("도착 클릭")

                        finish = "\(concert.address)"
                        finishLike = LikeDataModel(uuid: concert.uuid,
                                                   _id: concert._id,
                                                   place_name: concert.concert,
                                                   place_url: "",
                                                   category_name: "",
                                                   distance: "",
                                                   road_address_name: concert.address,
                                                   cate: "",
                                                   img: "",
                                                   isLike: false,
                                                   x: concert.posX,
                                                   y: concert.posY)
                        print("\(finishLike.place_name)")
                    }) {
                        Text("🏁도착")
                            .font(.system(size: 8.5))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("HolicGray"))
                    }
                    .frame(width: 55, height: 30)
                    .background(Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color("HolicGray"), lineWidth: 2)
                    )
                    .cornerRadius(7)
                    
                }
                
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
        }
    }
}


//struct concertCell_Previews: PreviewProvider {
//    static var previews: some View {
//        concertCell()
//    }
//}
