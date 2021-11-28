//
//  AppPlayer.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import AVFoundation
import UIKit

enum AppPlayerState {
    case idle
    case playing
    case pause
    case stop
}
class AppPlayer {
    var  player : AVPlayer?
    var timerChangeValue : ((Float)->Void)?
    var playerState : AppPlayerState = .idle
    /*Setup/prepare player */
    func setUpPlayerWithUrl(url: URL, into view : UIView){
        let asset = AVAsset(url: url)
        let playeritem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem : playeritem)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
       // NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    //
    }
    /*Time Observer to monintor continues playing time of player*/
    func addPlayerTimeChangeObserver() {
        let mainQueue = DispatchQueue.main
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        guard let player = player else {
            return
        }
        player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = player.currentItem else {return}
            guard currentItem.status == .readyToPlay else {
                return
            }
            self?.timerChangeValue?(currentItem.currentTime().seconds.isNaN ? 0 : Float(currentItem.duration.seconds))
            
        })
    }
    /* Play only if player is Not playing */
  func playIfNeeded() {
    guard let player = player else {
        return
    }
    if playerState  != .playing {
        player.play()
        playerState = .playing
    }
    }
    /* pause only if already playing*/
    func   pauseIfNeeded() {
        guard let player = player else {
            return
        }
        if playerState  == .playing {
            player.pause()
            playerState = .pause
        }
    }
    /*time scale is in 1000 */
    func seekTo( time : Int64) {
        player?.seek(to: CMTimeMake(value: time, timescale: 1000))
    }
}

