//
//  DetailMovieView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//

import SwiftUI
import RxSwift

struct DetailMovieView: View {
    @State var isFavorite: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var showMovieWebView = false
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Color("PrimaryColor")
                ScrollView {
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image("image-movie-default2").resizable()
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                            }.buttonStyle(.borderedProminent).clipShape(.circle).tint(.white).foregroundStyle(.black).padding().padding(EdgeInsets(top: 28, leading: 10, bottom: 0, trailing: 0))
                        }
                    }.frame(maxWidth: .infinity, maxHeight: 240).background(.red).padding(.bottom, 12)
                    HStack( content: {
                        VStack {
                            Rectangle().overlay {
                                Image("image_example").resizable()
                            }.frame(width: 100, height: 140).padding(.trailing, 8).cornerRadius(20).padding(.bottom, 8)
                        }
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Venom the Last Dance")
                                    .font(Font.system(size: 20, weight: .medium))
                                    .foregroundStyle(.white)
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Text("Genres:")
                                    .font(.subheadline)
                                    .frame(alignment: .leading)
                                    .padding(.trailing, 8)
                                
                                Text("Action")
                                    .font(.subheadline).fontWeight(.semibold)
                            }
                            HStack {
                                Text("Release:")
                                    .font(.subheadline)
                                    .frame(minWidth: 0, alignment: .leading)
                                    .padding(.trailing, 12)
                                Text("2024-2-12")
                                    .font(.subheadline)
                                    .frame(minWidth: 0, alignment: .leading)
                                Spacer()
                            }
                            
                            HStack {
                                Text("Language:")
                                    .font(.subheadline)
                                    .frame(minWidth: 0, alignment: .leading)
                                    .padding(.trailing, 12)
                                Text("en")
                                    .font(.subheadline)
                                    .frame(minWidth: 0, alignment: .leading)
                                Spacer()
                            }
                            Spacer()
                        }
                        .foregroundColor(Color("SecondaryColor"))
                        
                    }).padding(.horizontal, 20).padding(.bottom, 16)
                    GeneralButton {
                        showMovieWebView = true
                    } content: {
                        HStack {
                            Image(systemName: "globe")
                            Text("Visit Official Website")
                        }
                    }
                    VStack {
                        HStack{
                            Text("Overview").foregroundStyle(.white).font(Font.system(size: 22, weight: .medium))
                            
                            Spacer()
                        }.padding(.top, 12).padding(.bottom, 4).padding(.leading, 4)
                        Text("Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.").foregroundStyle(Color("SecondaryColor")).font(.subheadline)
                    }.padding(.horizontal, 12)
                    VStack {
                        HStack{
                            Text("Production Companies").foregroundStyle(.white).font(Font.system(size: 22, weight: .medium))
                            
                            Spacer()
                        }.padding(.top, 12).padding(.bottom, 4).padding(.leading, 4)
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .center, spacing: 20) {
                                ForEach((1...10), id: \.self) { _ in
                                    CompanyListItem()
                                    
                                }
                            }
                        }
                        
                    }.padding(.horizontal, 12)
                    
                    
                }
            }.sheet(isPresented: $showMovieWebView, content: {
                VStack {
                    HStack {
                        Image(systemName: "chevron.backward").foregroundColor(.white).padding(.leading, 12)
                        Text("Back").font(.system(.title3)).foregroundColor(.white).onTapGesture {
                            showMovieWebView.toggle()
                        }
                        Spacer()
                    }.padding(.top, 8)
                    GeneralWebview(urlString: "https://venom.movie")
                }.background(Color("PrimaryColor"))
                
            })
            //MARK: - Ignore safe area for top and bottom
            .ignoresSafeArea()
        }.background(Color("PrimaryColor")).navigationBarBackButtonHidden(true)
    }
}


#Preview {
    DetailMovieView()
}
