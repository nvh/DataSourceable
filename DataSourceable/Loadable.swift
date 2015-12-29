//
//  LoadableDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public enum Result<Value, E> {
    case Success(Value)
    case Failure(E)
}

public protocol Loadable: class {
    associatedtype Data : EmptyCheckable
    var state: State<Data,ErrorType> { get set }
    func loadData(completion: (Result<Data,ErrorType>) -> Void)
}

public extension Loadable {
    func reload(completion: () -> Void) {
        state = state.toLoading()
        loadData { result in
            switch result {
            case .Success(let data):
                self.state = self.state.toReady(data)
            case .Failure(let error):
                self.state = self.state.toError(error)
            }
            completion()
        }
    }
    
    var data: Data? {
        return state.data
    }
}
