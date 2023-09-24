//
//  spaceCell.swift
//  Holiculture
//
//  Created by 민지은 on 2023/07/29.
//

import SwiftUI

struct EmptyTicket: View {
    var body: some View {
        VStack{
            Text("🎫")
                .font(.system(size: 90))
                
            Text("등록된 티켓이 없습니다!")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("HolicGray"))
            
        }
        .padding(.top, -70)
    }
}

struct EmptyTicket_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTicket()
    }
}
