//
//  ContentView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 22/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var profilePresenter = ProfilePresenter()
    @EnvironmentObject var homePresenter: HomePresenter
    var body: some View {
        HomeView(homePresenter: homePresenter).environmentObject(profilePresenter)
    }
}

#Preview {
    ContentView()
}
