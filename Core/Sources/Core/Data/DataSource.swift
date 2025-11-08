//
//  DataSource.swift
//  Core
//
//  Created by Achmad Rijalu on 08/11/25.
//

import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) -> AnyPublisher<Response, Error>
}
