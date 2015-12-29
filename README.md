# DataSourceable

A protocol oriented way of handling datasources in Swift.

Tired of writing `tableView(tableView: UITableView, numberOfRowsInSection section: Int)` and `numberOfSectionsInTableView(tableView: UITableView)` etc. over and over again? This library is for you.

The short version:

```swift
struct MovieTitleDataSource: TableViewDataSourceable, DataContaining {
    typealias Data = [String]
    typealias Section = Data
    var data: Data? = ["Casino Royale","Quantum of Solace","Skyfall","Spectre"]

    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String {
        return "default"
    }

    func configure(cell cell: UITableViewCell, forItem item: String, inView view: UITableView) -> UITableViewCell {
        cell.textLabel?.text = item
    return cell
    }
}

let tableView: UITableView
//...
let dataSource = MovieTitleDataSource()
let proxy = TableViewDataSourceProxy(dataSource: dataSource)
tableView.dataSource = proxy
```

See a working example in README.playground