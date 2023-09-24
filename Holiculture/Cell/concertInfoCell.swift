//
//  concertInfoCell.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/21.
//

import SwiftUI

struct concertInfoCell: View {
    
    @State var option: String
    @State var optionData: String
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4))
            HStack{
                Text("\(option)")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .frame(width: 45, alignment: .leading)
                    .padding(.trailing, 27)
                
                Text("\(optionData)")
                    .font(.system(size: 12))
                    .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                    .minimumScaleFactor(0.6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//struct concertInfoCell_Previews: PreviewProvider {
//    static var previews: some View {
//        concertInfoCell()
//    }
//}
