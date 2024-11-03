//
//  ProfileWebview.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 03/11/24.
//


import WebKit
import SwiftUI


struct ProfileWebview: UIViewRepresentable {
    
    var url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
