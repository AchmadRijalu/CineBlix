//
//  CineBlixApp.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 22/11/23.
//

import SwiftUI
import netfox

@main
struct CineBlixApp: App {
    @StateObject var tabBarPresenter = CustomTabBarPresenter()
    let homePresenter = HomePresenter(homeUseCase: Injection().provideHome())
    let searchPresenter = SearchPresenter(searchMovieUseCase: Injection().provideSearchMovie())
    var body: some Scene {
        WindowGroup {
            MainTabbar()
                .environmentObject(tabBarPresenter)
                .environmentObject(homePresenter)
                .environmentObject(searchPresenter)
                .onAppear {
                NFX.sharedInstance().start()
            }
        }
    }
}
