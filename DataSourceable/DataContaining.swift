//
//  DataContaining.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol DataContaining {
    associatedtype Data: ElementsContaining
    var data: Data? { get }
    var numberOfItems: Int { get }
    func item(atIndex index: Int) -> Data.Element?
}

public extension DataContaining {
    public var numberOfItems: Int {
        return data?.count ?? 0
    }
    
    public func item(atIndex index: Int) -> Data.Element? {
        return data?[index]
    }
}