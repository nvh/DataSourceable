//
//  ElementsContaining.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol ElementsContaining {
    typealias Element
    var count: Int { get }
    subscript(index: Int) -> Element? { get }
}

extension Indexable where Index == Int {
    var count: Int {
        return endIndex
    }
    
    public subscript(index: Int) -> _Element? {
        guard 0 <= index && index < endIndex else {
            return nil
        }
        let element: _Element = self[index]
        return element
    }
}

extension Array: ElementsContaining {}
