//
//  Interactor.swift
//  Core
//
//  Created by Achmad Rijalu on 08/11/25.
//

import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        self._repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        _repository.execute(request: request)
    }
}
