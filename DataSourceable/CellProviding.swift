//
//  CellProviding.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol CellProviding {
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String
}

public protocol TableViewCellProviding: CellProviding {
    associatedtype TableViewCellType: Configurable
}

public protocol CollectionViewCellProviding: CellProviding {
    associatedtype CollectionViewCellType: Configurable
}