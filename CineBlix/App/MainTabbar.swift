//
//  ContentView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 22/11/23.
//

import SwiftUI

struct MainTabbar: View {
    @State var selectedTab: TabSelection = .home
    @StateObject var profilePresenter = ProfilePresenter()
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var searchPresenter: SearchPresenter
    @EnvironmentObject var customTabbarPresenter: CustomTabBarPresenter
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView(homePresenter: homePresenter).environmentObject(profilePresenter)
                case .search:
                    NavigationView {
                        SearchMovieView(searchPresenter: searchPresenter)
                    }
                }
            }
            CustomTabBar(tabSelection: $selectedTab).opacity(customTabbarPresenter.isHidden ? 0 : 1).offset(y: customTabbarPresenter.isHidden ? 100: 0).animation(.easeInOut(duration: 0.3), value: customTabbarPresenter.isHidden)
        }
    }
}

#Preview {
    MainTabbar()
}
