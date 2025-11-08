//
//  Presenter.swift
//  Core
//
//  Created by Achmad Rijalu on 08/11/25.
//

import Combine

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published public var list: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    
    init( _useCase: Interactor) {
        self._useCase = _useCase
    }
    
}
