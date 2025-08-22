//
//  DetailMovieReviewListItem.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 24/07/25.
//

import SwiftUI

struct ReviewListItem: View {
    var detailMovieReviewModel: DetailMovieReviewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(detailMovieReviewModel.name).font(.system(size: 14, weight: .semibold))
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                    Text(String(detailMovieReviewModel.rating)).font(.system(size: 14, weight: .regular))
                }
            }
            Text(detailMovieReviewModel.content).font(.system(size: 12, weight: .regular))
        }.foregroundColor(Color("SecondaryColor"))
    }
}

#Preview {
    ReviewListItem(detailMovieReviewModel: DetailMovieReviewModel(name: "Upin ipin", rating: 9.10, content: "Whatever happened to Brenton Thwaites? For some reason that crossed my mind as this thoroughly entertaining fantasy adventure gets off to a rollicking start and keeps going. Now if you are the -esque Viking chief (Gerard Butler) expecting your son to take over as fearless dragon-chaser after you, why would you call him ? Might as well call him Anyway, that hapless lad (Mason Thames) maybe isn't the most adept on the muscle front but cerebrally he has something of the Leonardo Da Vinci to him as he det..."))
}
