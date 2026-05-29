//
//  Mapper.swift
//  Core
//
//  Created by Achmad Rijalu on 21/11/25.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
}

public extension Mapper {
    func transformResponseToDomain(response: Response) -> Domain {
        transformEntityToDomain(entity: transformResponseToEntity(response: response))
    }
}
