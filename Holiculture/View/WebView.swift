//
//  WebView.swift
//  Holiculture
//
//  Created by 민지은 on 2023/09/16.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    var onDismiss: ((String) -> Void)? // 클로저를 통해 데이터를 반환할 수 있도록 함

    init(request: URLRequest, onDismiss: ((String) -> Void)?) {
        self.webView = WKWebView()
        self.request = request
        self.onDismiss = onDismiss
        self.webView?.configuration.userContentController.add(ContentController(onDismiss: onDismiss), name: "callBackHandler")
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject {
        let parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }
    }
}

class ContentController: NSObject, WKScriptMessageHandler {
    var onDismiss: ((String) -> Void)?
    var address = ""

    init(onDismiss: ((String) -> Void)?) {
        self.onDismiss = onDismiss
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
        }

        print(address)

        // 주소 데이터를 가져온 후 클로저를 호출하여 데이터를 반환하고 WebView를 닫음
        onDismiss?(address)
    }
}



//
//import SwiftUI
//import WebKit
//
//struct WebView: View {
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//    let request: URLRequest
//    var onDismiss: ((String) -> Void)? // 클로저를 통해 데이터를 반환할 수 있도록 함
//
//    var body: some View {
//        // NavigationView로 감싸서 내부에 Back button을 커스텀합니다.
//        NavigationView {
//            WebViewContainer(request: request, onDismiss: onDismiss)
//        }
//        .navigationBarBackButtonHidden(true) // 현재 뷰의 Back button을 숨깁니다.
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//
//                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 10)
//                        .foregroundColor(Color("HolicBlue"))
//                }
//            }
//        }
//    }
//
//    private func onBackTapped() {
//        // Back button이 눌렸을 때 실행할 동작을 여기에 추가하세요.
//    }
//}
//
//struct WebViewContainer: UIViewRepresentable {
//    let request: URLRequest
//    var onDismiss: ((String) -> Void)?
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        webView.configuration.userContentController.add(ContentController(onDismiss: onDismiss), name: "callBackHandler")
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.load(request)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebViewContainer
//
//        init(parent: WebViewContainer) {
//            self.parent = parent
//        }
//
//        // WKNavigationDelegate에서 필요한 메서드들을 구현하세요.
//        // 예를 들어, 페이지 로딩이 완료됐을 때의 동작 등을 여기에서 처리할 수 있습니다.
//    }
//}
//
//
//class ContentController: NSObject, WKScriptMessageHandler {
//    var onDismiss: ((String) -> Void)?
//    var address = ""
//
//    init(onDismiss: ((String) -> Void)?) {
//        self.onDismiss = onDismiss
//    }
//
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if let data = message.body as? [String: Any] {
//            address = data["roadAddress"] as? String ?? ""
//        }
//
//        print(address)
//
//        // 주소 데이터를 가져온 후 클로저를 호출하여 데이터를 반환하고 WebView를 닫음
//        onDismiss?(address)
//    }
//}
//
//
