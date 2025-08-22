//
//  GeneralButton.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 11/12/24.
//

import SwiftUI

struct GeneralButton<Content: View> : View {
    let action: () -> Void
    let content: () -> Content
    let color: Color
    var body: some View {
        Button(action: action) {
            content().frame(maxWidth: .infinity).foregroundStyle(.white).padding(.horizontal, 24).padding(.vertical, 12).background(color).clipShape(.capsule).padding(.horizontal, 16)
        }
    }
}

#Preview {
    GeneralButton(action: {
        
    }, content: {
        Text("Button")
    }, color: .yellow)
}

