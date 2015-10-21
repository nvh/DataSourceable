//
//  State.swift
//  DataSourcable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public enum State<D : EmptyCheckable,E> {
    case Empty
    case Loading(D?)
    case Ready(D)
    case Error(E,D?)
    
    func toLoading() -> State {
        switch self {
        case .Ready(let oldData):
            return .Loading(oldData)
        default:
            return .Loading(nil)
        }
    }
    
    func toError(error:E) -> State {
        switch self {
        case .Loading(let oldData):
            return .Error(error,oldData)
        default:
            assert(false, "Invalid state transition to .Error from other than .Loading")
        }
    }
    
    func toReady(data: D) -> State {
        switch self {
        case .Loading:
            if data.isEmpty {
                return .Empty
            } else {
                return .Ready(data)
            }
        default:
            assert(false, "Invalid state transition to .Ready from other than .Loading")
        }
    }
    
    var data: D? {
        switch self {
        case .Empty:
            return nil
        case .Ready(let data):
            return data
        case .Loading(let data):
            return data
        case .Error(_, let data):
            return data
        }
    }
    
    var error: E? {
        switch self {
        case .Error(let error, _):
            return error
        default:
            return nil
        }
    }
}
