//
//  DataSourceType.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol DataSourceType {
    typealias Data: Indexable
    var data: Data? { get }
    var numberOfItems: Int { get }
    func item(atIndex index: Data.Index) -> Data._Element?
}

public extension DataSourceType where Data.Index == Int {
    public var numberOfItems: Int {
        return data?.endIndex ?? 0
    }
    
    public func item(atIndex index: Data.Index) -> Data._Element? {
        guard 0 <= index && index < numberOfItems else {
            return nil
        }
        return data?[index]
    }
}