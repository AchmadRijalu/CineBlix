//
//  SearchListItem.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 19/08/25.
//

import SwiftUI
import Kingfisher

struct SearchMovieListItem: View {
    let movieImage: String?
    let movieTitle: String
    let movieRatings: Double

    var body: some View {
        HStack(spacing: 14) {
            KFImage.url(
                URL(string: Endpoints.Gets.image(imageFilePath: movieImage ?? "").url)
            )
            .placeholder {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.15))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(Color("WhiteColor").opacity(0.5))
                    }
            }
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 72, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 8) {
                Text(movieTitle)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("WhiteColor"))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 12))

                    Text(String(format: "%.1f", movieRatings))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color("WhiteColor").opacity(0.9))
                }

                Spacer(minLength: 0)
            }
            .frame(maxHeight: 108, alignment: .top)

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("WhiteColor").opacity(0.5))
        }
        .padding(12)
        .background(Color.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        }
    }
}
