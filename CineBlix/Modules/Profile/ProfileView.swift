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
                    Button(action: {
                        SharedMethods().openEmailApp()}
                    ){ Text("Contact Me")
                            .foregroundColor(.black).fontWeight(.medium)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .padding()
                            .background(SwiftUI.Color("GreenColor"))
                            .cornerRadius(8)
                    }
                    Button(action: {
                        showWebView.toggle()}
                    ) { Text("Linkedin").fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .padding()
                            .background(SwiftUI.Color("BlueColor"))
                            .cornerRadius(8)
                    }
                    Spacer()
                }.padding(.top, 12)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(SwiftUI.Color("PrimaryColor").edgesIgnoringSafeArea(.all))
                .navigationTitle("About").navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showWebView) {
                    VStack {
                        VStack {
                            HStack {
                                Image(systemName: "arrow.backward").foregroundColor(.white).padding(.leading, 12)
                                Text("Back").font(.system(.title3)).foregroundColor(.white).onTapGesture {
                                    showWebView.toggle()
                                }
                                Spacer()
                            }
                        }.frame(maxWidth: .infinity).background(SwiftUI.Color("PrimaryColor"))
                        GeneralWebview(urlString: "https://www.linkedin.com/in/achmadrijalu/")
                    }
            }
        }
    }
}

#Preview {
    ProfileView()
}
