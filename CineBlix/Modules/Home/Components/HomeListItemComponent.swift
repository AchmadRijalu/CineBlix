//
//  HomeListItemComponent.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 31/10/24.
//

import SwiftUI

struct HomeListItemComponent: View {
    var body: some View {
        VStack {
            Image("image_example").resizable().scaledToFit()
        }.frame(width: 116, height: 173).cornerRadius(12)
    }
}

#Preview {
    HomeListItemComponent()
}
