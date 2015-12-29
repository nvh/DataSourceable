//
//  UITableView.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 22/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

extension UITableView {
    func setDataSource(dataSource: TableViewDataSource) {
        self.dataSource = TableViewDataSourceProxy(dataSource: dataSource)
    }

}