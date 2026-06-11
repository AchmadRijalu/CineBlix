//
//  UseCase.swift
//  Core
//
//  Created by Achmad Rijalu on 08/11/25.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
