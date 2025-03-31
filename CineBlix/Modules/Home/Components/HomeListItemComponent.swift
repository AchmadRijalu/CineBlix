//
//  HomeListItemComponent.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 31/10/24.
//

import SwiftUI
import Kingfisher

struct HomeListItemComponent: View {
    
    var movieImage: String?
    var body: some View {
        VStack {
            KFImage.url(URL(string: movieImage ?? "")).resizable().scaledToFit()
        }.frame(width: 116, height: 173).cornerRadius(12)
    }
}

#Preview {
    HomeListItemComponent()
}
