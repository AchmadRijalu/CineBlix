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
    let homePresenter = HomePresenter(homeUseCase: Injection().provideHome())
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(homePresenter).onAppear {
                NFX.sharedInstance().start()
            }
        }
    }
}
