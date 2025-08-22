//
//  DetailmovieReviewSection.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 24/07/25.
//

import SwiftUI
import SkeletonUI

struct DetailmovieReviewSection: View {
    @ObservedObject var detailMoviePresenter: DetailMoviePresenter
    
    var body: some View {
        let reviews = detailMoviePresenter.detailMovieReviewModel ?? []
        List {
            if detailMoviePresenter.loadingState {
                ForEach(0..<3, id: \.self) { _ in
                    ReviewListItem(
                        detailMovieReviewModel: DetailMovieReviewModel(
                            name: "Title",
                            rating: 0,
                            content: ""
                        )
                    )
                    .skeleton(
                        with: true,
                        size: CGSize(
                            width: UIScreen.main.bounds.width,
                            height: 30
                        ),
                        animation: .pulse(
                            duration: 0.8,
                            delay: 0.2,
                            speed: 0.8,
                            autoreverses: true
                        ),
                        appearance: .solid(color: .gray,background: .gray),
                        shape: .rectangle
                    )
                }
                .listRowBackground(Color.clear)
                .transition(.opacity.combined(with: .scale))
                
            } else if !reviews.isEmpty {
                ForEach(reviews, id: \.self) { review in
                    ReviewListItem(detailMovieReviewModel: review)
                        .listRowBackground(Color.clear)
                }
                .transition(.opacity.combined(with: .scale))
                
            } else {
                VStack {
                    Image("image.empty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 16)
                    Text("No reviews available")
                        .foregroundColor(Color("SecondaryColor"))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.clear)
                .transition(.opacity)
            }
        }
        .listStyle(.plain)
        .animation(.easeInOut(duration: 0.3), value: detailMoviePresenter.loadingState)
    }
}

#Preview {
    var detailMovieUseCase = Injection.init().provideDetailMovie()
    DetailmovieReviewSection(detailMoviePresenter: DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: 912649 ))
}
