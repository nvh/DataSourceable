//
//  UICollectionView.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

extension UICollectionView {
    func setDataSource(dataSource: CollectionViewDataSource) {
        self.dataSource = CollectionViewDataSourceProxy(dataSource: dataSource)
    }
    
}