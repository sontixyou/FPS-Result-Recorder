//
//  UpdatePage.swift
//  VarolantVersus
//
//  Created by KENGO on 2020/08/30.
//  Copyright © 2020 KENGO NISHIMURA. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView(frame: .zero)
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: url)
        uiView.load(req)
    }
}
struct UpdatePage: View {
   var url: URL
var body: some View {
    WebView(url: url)
}

}


struct UpdatePage_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePage(url: URL(string: "https://playvalorant.com/en-us/")!)
    }
}
