//
//  Assets+Sendable.swift
//  CommonKit
//
//  Created by Achmad Rijalu on 16/11/25.
//

#if swift(>=5.9)
extension ColorAsset: @unchecked Sendable {}
extension ImageAsset: @unchecked Sendable {}
#endif

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
public extension ColorAsset {
    var safeSwiftUIColor: SwiftUI.Color {
        SwiftUI.Color(asset: self)
    }
}

#endif
