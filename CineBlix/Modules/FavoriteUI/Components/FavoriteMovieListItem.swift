//
//  FavoriteMovieItem.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 14/07/25.
//

import SwiftUI
import Kingfisher

struct FavoriteMovieItem: View {
    let movieImage: String?
    let movieTitle: String
    let movieRatings: Double
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            KFImage(
                URL(
                    string: "https://image.tmdb.org/t/p/w500\(movieImage ?? "")"
                )
            )
            .placeholder {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 6) {
                Text(movieTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 13))
                    
                    Text(String(format: "%.1f", movieRatings))
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical, 8)
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "trash.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Color.red)
                    .clipShape(Circle())
            }
            .padding(.trailing, 8)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    FavoriteMovieItem(
        movieImage: "/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg",
        movieTitle: "The Shawshank Redemption: A Long and Emotional Journey Through Hope and Despair",
        movieRatings: 9.3,
        onDelete: {}
    )
}

