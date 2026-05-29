//
//  SharedMethods.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 03/11/24.
//


import SwiftUI

class SharedMethods {
    func openEmailApp() {
        if let url = URL(string: "mailto:achmad.rijalu@gmail.com") {
            UIApplication.shared.open(url)
        }
    }
}
