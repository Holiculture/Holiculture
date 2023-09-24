//
//  testNavigation.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/20.
//
import SwiftUI

struct testNavigation: View {
    @State var address = ""
    
    @State var activeWebView = false
    @State var isNavigationActive = false
    
    var body: some View {
            NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://minchelin42.github.io/Kakao-PostAPI/")!), onDismiss: { receiveAddress in
                address = receiveAddress // 주소 데이터를 저장
            }), isActive: $isNavigationActive){
                
                Button(action: {
                    print("티켓 클릭")
                    isNavigationActive = true
                }) {
                    HStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 90, height: 120)
                            .background(
                                
                                Image("image1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 120)
                                    .clipped()
                                
                            )}
                    
                    .cornerRadius(0)
                    .padding(.trailing, 7)
                    
                    VStack {
                        HStack{
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 2, height: 15)
                                .background(Color("HolicBlue"))
                            
                            Text("콘서트명")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black)
                                .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                                .minimumScaleFactor(0.7)
                            
                        }
                        .padding(.bottom, 13)
                        
                        Text("장소")
                            .font(.system(size: 11))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                            .lineLimit(1) // 텍스트가 너무 길 경우 한 줄로 표시
                            .minimumScaleFactor(0.7)
                            .padding(.bottom, 1)
                        
                        Text("일시")
                            .font(.system(size: 11))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                            .padding(.bottom, 1)
                        
                        Text("좌석")
                            .font(.system(size: 11))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                        
                    } //VStack
                    .frame(maxWidth: 220, alignment: .leading)
                    //                .background(.blue)
                    //                .padding(.leading, 24)
                    
                }
                
                
                
                
            }
            .foregroundColor(.clear)
            .frame(width: 353, height: 156)
            .background(.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.83, green: 0.83, blue: 0.83).opacity(0.4), lineWidth: 1)
            )
        
        
        
        
        
        
        
    }
}

struct testNaviagtion_Previews: PreviewProvider {
    static var previews: some View {
        testNavigation()
    }
}




