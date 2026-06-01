//
//  HomeListRequest.swift
//  Home
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct HomeListRequest: Sendable {
    public static let nowPlayingListType = "now_playing"

    public let endpointURL: String
    public let listType: String
    public let usesCache: Bool

    public init(endpointURL: String, listType: String, usesCache: Bool) {
        self.endpointURL = endpointURL
        self.listType = listType
        self.usesCache = usesCache
    }
}
