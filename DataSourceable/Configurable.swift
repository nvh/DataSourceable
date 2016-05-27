//
//  Configurable.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 25/05/16.
//  Copyright © 2016 Zeker Waar. All rights reserved.
//

import Foundation

public protocol Configurable: ViewDefining {
    associatedtype ItemType
    func configure(forItem item: ItemType, inView: ContainingViewType)
}

public protocol ViewDefining {
    associatedtype ContainingViewType
}

extension UITableViewCell: ViewDefining {
    public typealias ContainingViewType = UITableView
}

extension UICollectionViewCell: ViewDefining {
    public typealias ContainingViewType = UICollectionView
}