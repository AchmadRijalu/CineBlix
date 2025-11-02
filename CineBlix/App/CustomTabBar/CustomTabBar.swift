//
//  CustomTabBar.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 15/09/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var tabSelection: TabSelection
    
    var body: some View {
        HStack {
            ForEach(TabSelection.allCases, id: \.self) { tab in
                Spacer()
                Button {
                    tabSelection = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: tabSelection == tab ? .semibold : .regular))
                        
                        Text(tab.title)
                            .font(.caption)
                            .fontWeight(tabSelection == tab ? .semibold : .regular)
                    }
                    .foregroundStyle(tabSelection == tab ? Color("PrimaryColor") : .gray)
                    .scaleEffect(tabSelection == tab ? 1.1 : 1.0)
                }
                .animation(.easeInOut(duration: 0.2), value: tabSelection)
                Spacer()
            }
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -2)
        )
    }
}
