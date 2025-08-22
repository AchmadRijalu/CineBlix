//
//  HomeListComponent.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI
import Kingfisher

struct HomeBannerComponent: View {
    
    var imageName: String
    var
    var body: some View {
        VStack {
            
            if isSkeleton {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .skeleton(
                        with: true,
                        size: CGSize(width: 116, height: 160),
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
                .scaledToFill()
                .frame(width: 116, height: 160)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("MovieDb \(String(format: "%.1f", movieRatings ?? 0))")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(6)
                    .offset(x: 25, y: -50)
            }
            Image("image_example").resizable().scaledToFill()
        }.frame(width: 335, height: 174).cornerRadius(12)
    }
}

#Preview {
    HomeBannerComponent(imageName: "")
}
