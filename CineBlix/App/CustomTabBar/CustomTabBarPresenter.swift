//
//  CustomTabBarPresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 15/09/25.
//

import SwiftUI

class CustomTabBarPresenter: ObservableObject {
    @Published var isHidden: Bool = false
    var depth: Int = 0
    
    func push() {
        depth += 1
        updateVisibility()
    }
    
    func pop() {
        depth = max(depth - 1, 0)
        updateVisibility()
    }
    
    private func updateVisibility() {
        isHidden = depth > 0
    }
}
