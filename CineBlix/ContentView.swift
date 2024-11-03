//
//  ContentView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 22/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var profilePresenter = ProfilePresenter()
    var body: some View {
        HomeView().environmentObject(profilePresenter)
    }
}

#Preview {
    ContentView()
}
