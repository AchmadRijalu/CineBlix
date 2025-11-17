//
//  MovieInfo.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 24/07/25.
//

import SwiftUI
import Kingfisher
import CommonKit

struct DetailMovieInfoSection: View {
    
    @ObservedObject var detailMoviePresenter: DetailMoviePresenter
    @Binding var isShowMovieWebsite: Bool
    var body: some View {
        ScrollView {
            HStack( content: {
                VStack {
                    KFImage.url(URL(string:Endpoints.Gets.image(imageFilePath: detailMoviePresenter.detailMovieModel?.posterPath ?? "").url))
                        .resizable()
                        .frame(width: 100, height: 140)
                        .scaledToFill()
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .skeleton(with: detailMoviePresenter.loadingState, size: CGSize(width: 100, height: 140),
                                  appearance: .solid(color: .gray,background: .gray),
                                  shape: .rounded(.radius(12, style: .circular)))
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(detailMoviePresenter.detailMovieModel?.title ?? "Movie Title")
                            .font(Font.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .skeleton(
                                with: detailMoviePresenter.loadingState,
                                appearance: .solid(color: .gray, background: .gray),
                                shape: .rectangle
                            )
                        Spacer()
                    }
                    
                    HStack(spacing: 12) {
                        Text("Genres:")
                            .font(.subheadline)
                            .frame(alignment: .leading)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if detailMoviePresenter.loadingState {
                                    ForEach(0..<3, id: \.self) { _ in
                                        Text("Genre")
                                            .font(.caption)
                                            .padding(6)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                            .skeleton(
                                                with: true,
                                                animation: .pulse(duration: 0.5, delay: 0.4, speed: 0.5, autoreverses: true),
                                                shape: .rounded(.radius(8)),
                                                lines: 0
                                            )
                                    }
                                } else {
                                    ForEach(detailMoviePresenter.detailMovieModel?.genres ?? [], id: \.self) { genre in
                                        Text(genre)
                                            .font(.caption)
                                            .padding(6)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8).lineLimit(0)
                                    }
                                }
                            }
                        }
                    }
                    HStack(spacing: 12){
                        Text("Release:")
                            .font(.subheadline)
                            .frame(minWidth: 0, alignment: .leading)
                        Text(detailMoviePresenter.detailMovieModel?.releaseDate ?? "")
                            .font(.subheadline)
                            .frame(minWidth: 0, alignment: .leading)
                            .skeleton(
                                with:
                                    detailMoviePresenter.loadingState,
                                appearance: .solid(color: .gray, background: .gray, ), shape: .rectangle)
                    }
                    HStack(spacing: 12){
                        Text("Duration:")
                            .font(.subheadline)
                        Text(detailMoviePresenter.convertToHoursFromMinutes(detailMoviePresenter.detailMovieModel?.runTime ?? 120))
                            .skeleton(
                                with: detailMoviePresenter.loadingState,
                                appearance: .solid(color: .gray, background: .gray),
                                shape: .rectangle
                            )
                    }
                }
                .foregroundColor(Color("SecondaryColor"))
            }).padding(.horizontal, 20).padding(.bottom, 16)
            GeneralButton(action: {
                isShowMovieWebsite.toggle()
            }, content: {
                HStack {
                    Image(systemName: "globe")
                    Text(localization.Screen.Detailmovie.Button.title)
                }
            }, color: Color("RedColor"))
            .skeleton(
                with: detailMoviePresenter.loadingState,
                size: CGSize(width: 200, height: 40),
                shape: .capsule,
            )
            
            VStack {
                HStack{
                    Text(localization.Screen.Detailmovie.Overview.subtitle)
                        .foregroundStyle(.white)
                        .font(Font.system(size: 22, weight: .medium))
                    Spacer()
                }.padding(.top, 12).padding(.bottom, 4).padding(.leading, 4)
                
                Text(detailMoviePresenter.detailMovieModel?.overview ?? "")
                    .foregroundStyle(Color("SecondaryColor"))
                    .font(.subheadline)
                    .skeleton(
                        with: detailMoviePresenter.loadingState,
                        animation: .pulse(duration: 0.5, delay: 0.9, speed: 0.5, autoreverses: true),
                        shape: .rectangle,
                        lines: 3
                    )
            }.padding(.horizontal, 12)
            
            VStack {
                HStack{
                    Text(localization.Screen.Detailmovie.Companies.subtitle)
                        .foregroundStyle(.white)
                        .font(Font.system(size: 22, weight: .medium))
                    Spacer()
                }.padding(.top, 12).padding(.leading, 4)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(detailMoviePresenter.detailMovieModel?.productionCompanies ?? [], id: \.self) { company in
                            CompanyListItem(companyImage: company.posterPath, companyName: company.name, companyCountry: company.originCountry)
                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
    }
}
