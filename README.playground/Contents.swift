//: Playground - noun: a place where people can play

import UIKit
import DataSourceable
import XCPlayground

let defaultReuseIdentifier = "default"

struct MovieTitleDataSource: TableViewDataSourceable, DataContaining {
    
    typealias Data = [String]
    typealias Section = Data
    var data: Data? = ["Casino Royale","Quantum of Solace","Skyfall","Spectre"]
    
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String {
        return defaultReuseIdentifier
    }
}

//This could also be your custom subclass of UITableViewCell
extension UITableViewCell: Configurable {
    public typealias ItemType = String
    public func configure(forItem item: ItemType, inView view: ContainingViewType) {
        textLabel?.text = item
    }
}

//Specify the class you would like this tableview to use here
extension MovieTitleDataSource: TableViewCellProviding {
    typealias TableViewCellType = UITableViewCell
}

let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 500))
let dataSource = MovieTitleDataSource()
let proxy = TableViewDataSourceProxy(dataSource: dataSource)
tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: defaultReuseIdentifier)
tableView.dataSource = proxy
XCPlaygroundPage.currentPage.liveView = tableView

