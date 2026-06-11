//
//  View.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 15/09/25.
//

import SwiftUI

/// Defers building the destination until NavigationLink is activated (avoids prefetching every row).
struct DeferredView<Content: View>: View {
    private let build: () -> Content

    init(@ViewBuilder _ build: @escaping () -> Content) {
        self.build = build
    }

    var body: some View {
        build()
    }
}

extension View {
    func hideTabBar() -> some View {
        modifier(HideTabBarModifier(hidden: true))
    }
    
    func showTabBar() -> some View {
        modifier(HideTabBarModifier(hidden: false))
    }
}

struct HideTabBarModifier: ViewModifier {
    @EnvironmentObject var tabBarPresenter: CustomTabBarPresenter
    var hidden: Bool
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if hidden { tabBarPresenter.push() }
            }
            .onDisappear {
                if hidden { tabBarPresenter.pop() }
            }
    }
}
