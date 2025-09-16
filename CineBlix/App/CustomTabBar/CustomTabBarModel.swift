//
//  MainTabbarModel.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 15/09/25.
//

import SwiftUI

enum TabSelection: Hashable, CaseIterable {
    case home
    case search
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        }
    }
}
