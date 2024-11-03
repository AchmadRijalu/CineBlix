//
//  ProfilePresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 03/11/24.
//

import Foundation
import SwiftUI

class ProfilePresenter: ObservableObject {
    
    private let router = ProfileRouter()
    
    func navigateToProfile<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        router.createProfileView()
    }
}
