//
//  CellProviding.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol CellProviding {
    associatedtype ItemType
    associatedtype CellType
    associatedtype ViewType
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String
    func configure(cell cell: CellType, forItem item: ItemType, inView view: ViewType) -> CellType
}

public protocol TableViewCellProviding: CellProviding {
    typealias CellType = UITableViewCell
    typealias ViewType = UITableView
    func configure(cell cell: UITableViewCell, forItem item: ItemType, inTableView tableView: UITableView) -> UITableViewCell
}

extension TableViewCellProviding where Self.CellType == UITableViewCell, Self.ViewType == UITableView {
    public func configure(cell cell: CellType, forItem item: ItemType, inView view: ViewType) -> Self.CellType {
        return configure(cell: cell, forItem: item, inTableView: view)
    }
}

public protocol CollectionViewCellProviding: CellProviding {
    typealias CellType = UICollectionViewCell
    typealias ViewType = UICollectionView
    func configure(cell cell: UICollectionViewCell, forItem item: ItemType, inCollectionView collectionView: UICollectionView) -> UICollectionViewCell
}

extension CollectionViewCellProviding where Self.CellType == UICollectionViewCell, Self.ViewType == UICollectionView {
    public func configure(cell cell: CellType, forItem item: ItemType, inView view: ViewType) -> Self.CellType {
        return configure(cell: cell, forItem: item, inCollectionView: view)
    }
}
