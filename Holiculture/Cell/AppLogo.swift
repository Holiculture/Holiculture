//
//  AppLogo.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/17.
//

import SwiftUI

struct appLogo: View {
    var body: some View {
        HStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 150, height: 20)
                .background(
                    Image("HolicultureLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 20)
                        .clipped()
                )
                .padding(.leading, 18)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .padding(.top, 15)
    }
        
}

struct appLogo_Previews: PreviewProvider {
    static var previews: some View {
        appLogo()
    }
}
