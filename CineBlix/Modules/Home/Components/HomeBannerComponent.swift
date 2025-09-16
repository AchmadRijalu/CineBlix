//
//  HomeListComponent.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI
import Kingfisher

struct HomeBannerComponent: View {
    var movieImage: String?
    var isSkeleton: Bool = false
    
    var body: some View {
        ZStack {
            if isSkeleton {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .skeleton(
                        with: true,
                        size: CGSize(width: 335, height: 174),
                        animation: .pulse(
                            duration: 0.8,
                            delay: 0.2,
                            speed: 0.8,
                            autoreverses: true
                        ),
                        appearance: .solid(color: .gray, background: .white),
                        shape: .rounded(.radius(12, style: .circular))
                    )
            } else {
                KFImage.url(
                    URL(string: Endpoints.Gets.image(imageFilePath: movieImage ?? "").url)
                )
                .cacheOriginalImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFill()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .frame(width: 335, height: 174)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


#Preview {
    HomeBannerComponent(movieImage: "")
}
