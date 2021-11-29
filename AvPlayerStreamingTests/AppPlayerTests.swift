//
//  AppPlayerTests.swift
//  AvPlayerStreamingTests
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import XCTest
@testable import AvPlayerStreaming

class AppPlayerTests: XCTestCase {

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
    func testPlayerSetup() throws {
        let player = setUpPlayer()
        XCTAssertNotNil(player?.player)
        XCTAssertNotNil(player?.player?.currentItem)
        
    }
    func testPlay() throws {
        guard let player = setUpPlayer()else{
            return
        }
        player.playIfNeeded()
        let exp = expectation(description: "Check player Play")
        
        if  player.player?.rate != 0 && player.player?.error == nil {
            exp.fulfill()
        }
        waitForExpectations(timeout: 10){
            error in


                XCTAssertNil(error)
     
    }
       
    }
    func testPause() throws {
        guard let player = setUpPlayer() else {
            return
        }
        player.playerState = .playing
        player.pauseIfNeeded()
        let exp  = expectation(description: "PlayerPauseExp")
        if player.playerState == .pause {
            exp.fulfill()
        }
        waitForExpectations(timeout: 10){ error in
            XCTAssertNil(error)
        }

    }
    func testGetPlayerDuration() throws {
        guard let player = setUpPlayer() else {
            return
        }
        let exp = expectation(description: "Get Media Duration")
        
        let result =   XCTWaiter.wait(for: [exp], timeout: 10)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(player.getMediaDuration())
            XCTAssertFalse(player.getMediaDuration()?.isNaN ?? false)
           
        }
        
        
       
        
    }
    func testPlayerTimeObsever() {
        guard let player = setUpPlayer() else {
            return
        }
        player.player?.play()
        player.addPlayerTimeChangeObserver()
        let exp = expectation(description: "Timer Value Change expectation")
        player.timerChangeValue = {value in
            if  value > 0.01{
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 10) { error in
               // XCTAssertNil(error)

            XCTAssertNil(error)
                }
           
        
        
    }
  
    func testPlayerSeek() throws {
        guard  let player = setUpPlayer() else {
            return
        }
        let timeToSeek = Int64(0.1 * 1000)
        player.seekTo(time: timeToSeek)
        let exp = expectation(description: "Player Seek")
        if  ((player.player?.currentTime().value) == timeToSeek) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 10){error in
            XCTAssertNil(error)
            
        }
    }
    func testPlayerState() throws {
        guard let player = setUpPlayer() else {
            return
        }
        let exp = expectation(description: "Player State test")
        player.listenToPlayerState = { value in
            if (value != .idle) {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 10){
            XCTAssertNil($0)
        }
    }
    
    func setUpPlayer()->AppPlayer? {
        let player = AppPlayer()
        player.setUpPlayerWithUrl(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!, into: UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200)))
        return player
    }
}
