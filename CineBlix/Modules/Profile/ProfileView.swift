//
//  ProfileView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI
import WebKit

struct ProfileView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
    }
    @Environment(\.presentationMode) var presentationMode
    @State private var showWebView = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("image-profile").resizable().aspectRatio(contentMode: .fill).frame(width: 200, height: 200)
                        .cornerRadius(100)
                }.padding(.top, 70).padding(.bottom, 16)
                VStack(spacing: 20) {
                    HStack {
                        Text("Achmad Rijalu").font(.title2).fontWeight(.medium).foregroundColor(.white)
                    }
                    HStack(alignment: .center) {
                        Text("iOS Engineer").font(.title3).fontWeight(.medium)
                            .multilineTextAlignment(.center).foregroundColor(.white)
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Spacer()
                    HStack {
                        GeneralButton(action: {
                            SharedMethods().openEmailApp()
                        }, content: {
                            Text("Contact Me").fontWeight(.medium)
                                    .foregroundColor(.black)
                        }, color: Color("GreenColor"))
                    }.padding(.horizontal, 24)
                    HStack {
                        GeneralButton(action: {
                            showWebView.toggle()
                        }, content: {
                            Text("Personal Website").fontWeight(.medium)
                                    .foregroundColor(Color("BlackColor"))
                        }, color: Color(.white))
                    }.padding(.horizontal, 24)
                    Spacer()
                }.padding(.top, 12)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(SwiftUI.Color("PrimaryColor").edgesIgnoringSafeArea(.all))
                .navigationTitle("About").navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showWebView) {
                    GeneralWebview(urlString: "https://www.achmadrijalu.com")
                }
        }
    }
}

#Preview {
    ProfileView()
}
