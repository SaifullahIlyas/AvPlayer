//
//  PlayerVCTests.swift
//  AvPlayerStreamingUITests
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import XCTest

@testable import AvPlayerStreaming
class PlayerVCTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
       

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testSetUpVC() throws {
      let sut = makeSUT()
     XCTAssert(checkIfViewIsInSuperview(superview: sut.view, subview: sut.playerView))
     XCTAssert(checkIfViewIsInSuperview(superview: sut.view, subview: sut.controlView))
     XCTAssert(checkIfViewIsInSuperview(superview: sut.controlView, subview: sut.playPauseBtn))
     XCTAssert(checkIfViewIsInSuperview(superview: sut.controlView, subview: sut.audioSubTitleBtn))
     XCTAssert(checkIfViewIsInSuperview(superview: sut.controlView, subview: sut.seekbar))
    
        
    }
    func checkIfViewIsInSuperview(superview pVw : UIView, subview sVw : UIView) -> Bool{
        return sVw.isDescendant(of: pVw)
    }
  
    
   private func makeSUT() -> PlayerVC {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let sut = storyboard.instantiateViewController(identifier: "PlayerVC") as! PlayerVC
            sut.loadViewIfNeeded()
            return sut
        }
    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

}
