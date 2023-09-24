//
//  cateConcertList.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/21.
//

import SwiftUI

struct cateConcertList: View {
    
    @State var cate: String
    var concerts: [ConcertDataModel]
    var body: some View {
        VStack{
            HStack{
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 2, height: 18)
                    .background(Color("HolicBlue"))
                
                Text("\(cate)")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading, 20)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(concerts, id: \._id) { concert in
                        if concert.cate == cate {
                            nowConcertCell(concert: concert)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4))
                .padding(.horizontal, 15)
        }
        .padding(.bottom, 10)
    }
}

//struct cateConcertList_Previews: PreviewProvider {
//    static var previews: some View {
//        cateConcertList(cate: "뮤지컬")
//    }
//}
