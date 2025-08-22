//
//  ProductionResponse.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 17/07/25.
//

import SwiftyJSON

struct ProductionCompanyResponse {
    let id: Int
    let name: String
    let originCountry: String
    let logoPath: String?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.originCountry = json["origin_country"].stringValue
        self.logoPath = json["logo_path"].string
    }
}
