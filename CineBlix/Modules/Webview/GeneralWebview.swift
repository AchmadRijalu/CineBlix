//
//  ProfileWebview.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 03/11/24.
//

import SwiftUI
import WebKit

struct GeneralWebview: UIViewRepresentable {
    var urlString: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

