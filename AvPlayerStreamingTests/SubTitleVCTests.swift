//
//  SubTitleVCTests.swift
//  AvPlayerStreamingTests
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import XCTest
@testable import AvPlayerStreaming

class SubTitleVCTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testCorollerHasTbVw() throws {
     let sut = makeSUT()
     XCTAssertNotNil(sut.tableView)
    }
    func testTableHasDataSource () throws {
    let sut = makeSUT()
    XCTAssertNotNil(sut.tableView.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() throws {
           let sut = makeSUT()
           XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
           XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
           XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
           XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
       }
    func testTableViewCellHasReuseIdentifier() {
           let sut = makeSUT()
            let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TbInfoCell
            let actualReuseIdentifer = cell?.reuseIdentifier
            let expectedReuseIdentifier = "TbInfoCell"
            XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        }
    private func makeSUT() -> SubTitleVC {
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let sut = storyboard.instantiateViewController(identifier: "SubTitleVC") as! SubTitleVC
             let player = AppPlayer()
        player.setUpPlayerWithUrl(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!, into: UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200)))
             sut.appPlayer = player
             sut.loadViewIfNeeded()
            
             return sut
         }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
