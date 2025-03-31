//
//  CompanyListItem.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 11/12/24.
//

import SwiftUI

struct CompanyListItem: View {
    var companyImage: String?
    var companyName: String?
    var companyCountry: String?
    var body: some View {
        VStack {
            Image("image-movie-default2").resizable().frame(width: 100, height: 100).clipShape(.circle).padding(.bottom, 12)
            Text("Columbia Pictures").foregroundStyle(Color("SecondaryColor")).font(.subheadline).padding(.bottom, 4)
            Text("US").foregroundStyle(Color("SecondaryColor")).font(.caption).font(Font.system(size: 12, weight: .semibold))
        }.padding()
    }
}

#Preview {
    CompanyListItem(companyImage: "")
}
