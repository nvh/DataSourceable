//
//  CellProviding.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol CellProviding {
    typealias ItemType
    typealias CellType
    typealias ViewType
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String
    func configure(cell cell: CellType, forItem item: ItemType, inView view: ViewType) -> CellType
}
