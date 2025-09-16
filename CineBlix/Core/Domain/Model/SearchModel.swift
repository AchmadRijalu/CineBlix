//
//  SearchModel.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/08/25.
//

struct SearchMovieModel: Equatable, Identifiable {
    let id: Int
    let posterPath: String
    var title: String
    let voteAverage: Double
}
