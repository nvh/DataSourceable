//
//  UITableView.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 22/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import Foundation

extension UITableView {
    func setDataSourceable<D: TableViewDataSourceable where D.ItemType == D.Section.Data._Element, D.Section.Data.Index == Int> (dataSourceable: D) {
        self.dataSource = TableViewDataSourceProxy(dataSource: dataSourceable)
    }

}