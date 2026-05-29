//
//  Presenter.swift
//  Core
//
//  Created by Achmad Rijalu on 08/11/25.
//

import Combine
import Foundation
import SwiftUI

public class GetListPresenter<Request, Item, UseCaseType: UseCase>: ObservableObject
where UseCaseType.Request == Request, UseCaseType.Response == [Item] {

    private var cancellables: Set<AnyCancellable> = []

    private let useCase: UseCaseType
    
    @Published public var list: [Item] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: UseCaseType) {
        self.useCase = useCase
    }

    public func getList(request: Request?) {
        isLoading = true
        useCase.execute(request: request).receive(on: RunLoop.main).sink { Completion in
            switch Completion {
            case .finished:
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
                
            }
        } receiveValue: { list in
            self.list = list
        }.store(in: &cancellables)

        
    }
    
}
