//
//  HomeListComponent.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI

struct HomeBannerComponent: View {
    
    var imageName: String
    var body: some View {
        VStack {
            Image("image_example").resizable().scaledToFill()
        }.frame(width: 335, height: 174).cornerRadius(12)
    }
}

#Preview {
    HomeBannerComponent(imageName: "")
}
