//
//  DataSourceTypeSpec.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import DataSourceable
import Quick
import Nimble

struct DataSource: DataContaining {
    var data: [Int]? = nil
}

class DataSourceTypeSpec: QuickSpec {
    override func spec() {
        describe("DataSourceType") {
            var dataSource =  DataSource()
            context("when data is nil") {
                beforeEach {
                    dataSource.data = nil
                }
                
                it("numberOfItems should return 0") {
                    expect(dataSource.numberOfItems).to(equal(0))
                }
                
                it("should return nil when requesting a item at index") {
                    for index in -5...5 {
                        expect(dataSource.item(atIndex: index)).to(beNil())
                    }
                }
            }
            
            context("when data is set") {
                let data = [4,5,6]
                beforeEach {
                    dataSource.data = data
                }
                it("should return the correct index") {
                    for (index, value) in data.enumerate() {
                        expect(dataSource.item(atIndex: index)).to(equal(value))
                    }
                }
                
                it("should return nil when index is greater than number of elements") {
                    expect(dataSource.item(atIndex: 3)).to(beNil())
                }

                it("should return nil when index is below 0") {
                    expect(dataSource.item(atIndex: -1)).to(beNil())
                }

            }
            
        }
    }
}
