//
//  LocaleDataSource.swift
//  Core
//
//  Created by Achmad Rijalu on 08/11/25.
//

import Foundation
import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Request]) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: String, entities: Response) -> AnyPublisher<Bool, Error>
}
