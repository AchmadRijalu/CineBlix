//
//  FavoriteView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    GeneralToolBar(action: {
                        dismiss()
                    }, title: "Favorites")
                    GeometryReader { geo in
                        VStack {
                            Text("Hao")
                        }
                    }
                }
            }
        }
       
    }
}

#Preview {
    FavoriteView()
}
