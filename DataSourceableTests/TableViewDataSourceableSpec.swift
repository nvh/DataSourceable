//
//  TableViewDataSourceableSpec.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 15/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import UIKit
import DataSourceable
import Quick
import Nimble

struct TitledSection<D: ElementsContaining>: SectionType {
    typealias Data = D
    typealias Element = D.Element
    var data: D?
    var footerTitle: String?
}

struct SimpleTableViewDataSource: TestTableViewSourceable {
    var data: [String:[Int]]? = ["b":[2,4,8],"a":[1,1,2,3],"c":[3,6,9]]

    func tableView(tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        return data?.keys.sort()[sectionIndex]
    }
}

extension SimpleTableViewDataSource: SectionCreating {
    typealias Section = [Int]
    func createSections(data: [String:[Int]]) -> [Section] {
        return data.keys.sort().flatMap { data[$0] }
    }
    
}

struct CustomSectionTableViewDataSource: TestTableViewSourceable {
    typealias Section = TitledSection<[Int]>
    var sections: [Section]? = [TitledSection(data: [42], footerTitle: "footer text")]
}


protocol TestTableViewSourceable: TableViewDataSourceable {}
extension TestTableViewSourceable {
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String {
        return "identifier"
    }
    
    func configure(cell cell: UITableViewCell, forItem item: Section.Data.Element, inView view: UITableView) -> UITableViewCell {
        cell.textLabel?.text = "\(item)"
        return cell
    }
}

class TableViewDataSourceableSpec: QuickSpec {
    override func spec() {
        describe("TableViewDataSourceable") {
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .Plain)
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identifier")
            context("with a simple tableview data source") {
                let simpleDataSource = SimpleTableViewDataSource()
                var proxy: TableViewDataSourceProxy! = nil
                beforeEach {
                    proxy = TableViewDataSourceProxy(dataSource: simpleDataSource)
                    tableView.dataSource = proxy
                }
                describe("tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int") {
                    it("should return 0 rows for section 0") {
                        expect(proxy.tableView(tableView, numberOfRowsInSection: 0)).to(equal(4))
                    }
                }
                describe("numberOfSectionsInTableView") {
                    it("should return 0") {
                        expect(proxy.numberOfSectionsInTableView(tableView)).to(equal(3))
                    }
                }
                
                describe("titleForHeaderInSection") {
                    it("should override the default implementation") {
                        let titles = ["a","b","c"]
                        for index in 0..<3 {
                            expect(proxy.tableView(tableView, titleForHeaderInSection: index)).to(equal(titles[index]))
                        }
                    }
                }

                describe("titleForFooterInSection") {
                    it("should use the default implementation") {
                        for index in 0..<3 {
                            expect(proxy.tableView(tableView, titleForFooterInSection: index)).to(beNil())
                        }
                    }
                }
                
                describe("cellForRowAtIndexPath") {
                    it("should return the configured cell") {
                        for section in 0..<proxy.numberOfSectionsInTableView(tableView) {
                            for row in 0..<proxy.tableView(tableView, numberOfRowsInSection: section) {
                                let indexPath = NSIndexPath(forRow: row, inSection: section)
                                let cell = proxy.tableView(tableView, cellForRowAtIndexPath:indexPath)
                                expect(cell.textLabel?.text).to(equal("\(simpleDataSource.sections![section][row])"))
                            }
                        }
                    }
                    it("should return an unconfigured cell for a non-existing indexpath") {
                        let cell = proxy.tableView(tableView, cellForRowAtIndexPath:(NSIndexPath(forRow: 6, inSection: 6)))
                        expect(cell.textLabel?.text).to(beNil())
                    }

                }
            }
            context("with a custom section tableview data source") {
                let customDataSource = CustomSectionTableViewDataSource()
                let proxy = TableViewDataSourceProxy(dataSource: CustomSectionTableViewDataSource())
                tableView.dataSource = proxy
                describe("tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int") {
                    it("should return 0 rows for section 0") {
                        expect(proxy.tableView(tableView, numberOfRowsInSection: 0)).to(equal(1))
                    }
                }
                describe("numberOfSectionsInTableView") {
                    it("should return 0") {
                        expect(proxy.numberOfSectionsInTableView(tableView)).to(equal(1))
                    }
                }
                
                describe("titleForHeaderInSection") {
                    it("should override the default implementation") {
                        expect(proxy.tableView(tableView, titleForHeaderInSection: 0)).to(beNil())
                    }
                }
                
                describe("titleForFooterInSection") {
                    it("should use the default implementation") {
                        expect(proxy.tableView(tableView, titleForFooterInSection: 0)).to(equal("footer text"))
                    }
                }
                
                describe("cellForRowAtIndexPath") {
                    it("should return the configured cell") {
                        for section in 0..<proxy.numberOfSectionsInTableView(tableView) {
                            for row in 0..<proxy.tableView(tableView, numberOfRowsInSection: section) {
                                let indexPath = NSIndexPath(forRow: row, inSection: section)
                                let cell = proxy.tableView(tableView, cellForRowAtIndexPath:indexPath)
                                expect(cell.textLabel?.text).to(equal("\(customDataSource.sections!.item(atIndex: section)!.item(atIndex:row)!)"))
                            }
                        }
                    }
                    it("should return an unconfigured cell for a non-existing indexpath") {
                        let cell = proxy.tableView(tableView, cellForRowAtIndexPath:(NSIndexPath(forRow: 6, inSection: 6)))
                        expect(cell.textLabel?.text).to(beNil())
                    }
                    
                }
                
            }
        }
    }
}