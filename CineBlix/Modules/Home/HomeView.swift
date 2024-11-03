//
//  HomeView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 09/09/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var profilePresenter: ProfilePresenter
    
    @State var isProfileShowed: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                Image("wave").resizable().frame(width: UIScreen.main.bounds.width)
                GeometryReader { geo in
                    VStack {
                        ScrollView(showsIndicators: false){
                            //MARK: - Banner
                            VStack {
                                ScrollView(.horizontal) {
                                    LazyHStack(alignment: .center, spacing: 20) {
                                        ForEach((1...10), id: \.self) { _ in
                                            HomeBannerComponent(imageName: "a")
                                        }
                                    }
                                }
                            }.padding(.leading, 12).frame(maxWidth: .infinity, maxHeight: 200).padding(.leading, -20).padding(.bottom, 56).padding(.top, 8)
                            //MARK: - Now Playing
                            HStack{
                                Text("Now Playing")
                                Spacer()
                            }.foregroundStyle(.white).font(.system(size: 24, weight: .semibold)).padding(.bottom, 22)
                            VStack {
                                ScrollView(.horizontal) {
                                    LazyHStack(alignment: .center, spacing: 20) {
                                        ForEach((1...10), id: \.self) { _ in
                                            HomeListItemComponent()
                                        }
                                    }
                                }
                            }.padding(.leading, 12).frame(maxWidth: .infinity, maxHeight: 200).padding(.leading, -20).padding(.bottom, 56)
                            
                            //MARK: - Popular
                            HStack{
                                Text("Popular")
                                Spacer()
                            }.foregroundStyle(.white).font(.system(size: 24, weight: .semibold)).padding(.bottom, 22)
                            VStack {
                                ScrollView(.horizontal) {
                                    LazyHStack(alignment: .center, spacing: 20) {
                                        ForEach((1...10), id: \.self) { _ in
                                            HomeListItemComponent()
                                        }
                                    }
                                }
                            }.padding(.leading, 12).frame(maxWidth: .infinity, maxHeight: 200).padding(.leading, -20).padding(.bottom, 56)
                        }
                        Spacer()
                    }
                    .padding(20).frame(maxWidth: geo.size.width, maxHeight:  geo.size.height)
                    .sheet(isPresented: $isProfileShowed) {
                        profilePresenter.navigateToProfile {}
                    }
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isProfileShowed = true
                        } label: {
                            Image("image-profile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                               
                        }
                        .buttonStyle(.borderless)
                        .clipShape(Circle()).tint(.black)
                    }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(Color("RedColor")).padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(Circle()).tint(.black)
                }
            }
        }
        
        
    }
}

#Preview {
    HomeView()
}
