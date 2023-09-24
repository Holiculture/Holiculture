//
//  emptyConcert.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/12.
//

import SwiftUI

struct EmptyConcert: View {
    var body: some View {
        VStack{
            Text("😅")
                .font(.system(size: 90))
                .padding(.bottom, 3)
            
            Text("해당 공연 정보가 등록되어 있지 않아요")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("HolicGray"))
                .padding(.bottom, 2)
            
            Text("직접 입력하는 것은 어떠신가요?")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("HolicGray"))
            
        }
        .padding(.top, -70)
    }
}

struct EmptyConcert_Previews: PreviewProvider {
    static var previews: some View {
        EmptyConcert()
    }
}
