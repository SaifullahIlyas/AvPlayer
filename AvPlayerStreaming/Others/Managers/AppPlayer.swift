//
//  AppPlayer.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import AVFoundation
import UIKit

fileprivate enum PlayerNotification : CustomStringConvertible {
    case bufferEmpty
    case bufferKeepUp
    case bufferFull
    var description: String {
        switch self {
        case .bufferEmpty:
            return Resources.strings.stringNotificationPlaybackBufferEmpty
        case .bufferKeepUp :
            return Resources.strings.stringNotificationPlaybackLikelyToKeepUp
        case .bufferFull:
            return Resources.strings.stringNotificationPlaybackBufferFull
        
        }
    }
}
enum AppPlayerState {
    case idle
    case unkown
    case playing
    case pause
    case finishedPlaying
    case buffering
}
class AppPlayer : NSObject {
    var  player : AVPlayer?
    var timerChangeValue : ((Float)->Void)?
    var didFinishedPlaying :(()->Void)?
    var listenToPlayerState : ((AppPlayerState)->Void)?
    var playerState : AppPlayerState = .idle
    /*Setup/prepare player */
    func setUpPlayerWithUrl(url: URL, into view : UIView){
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem : playerItem)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
       NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        playerItem.addObserver(self, forKeyPath: PlayerNotification.bufferEmpty.description, options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: PlayerNotification.bufferKeepUp.description, options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: PlayerNotification.bufferFull.description, options: .new, context: nil)
    
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
                self?.setPlayerState(state: .unkown)
                return
            }
            self?.timerChangeValue?(currentItem.currentTime().seconds.isNaN ? 0 : Float(currentItem.currentTime().seconds))
            
        })
    }
    @objc func finishedPlaying() {
        setPlayerState(state: .finishedPlaying)
        didFinishedPlaying?()
       
    }
    
    /* Play only if player is Not playing */
  func playIfNeeded() {
    guard let player = player else {
        return
    }
    if playerState  != .playing {
        player.play()
        setPlayerState(state: .playing)
    }
    }
    /* pause only if already playing*/
    func   pauseIfNeeded() {
        guard let player = player else {
            return
        }
        if playerState  == .playing {
            player.pause()
            setPlayerState(state: .pause)
        }
    }
    /*time scale is in 1000 */
    func seekTo( time : Int64) {
        player?.seek(to: CMTimeMake(value: time, timescale: 1000))
    }
    func getMediaDuration() -> Double? {
        guard let player = player else {
            return nil
        }
        guard let currentItem = player.currentItem else {
            return nil
        }
       return currentItem.duration.seconds
    }
    func reset() {
        player?.seek(to: CMTime(value: 0, timescale: CMTimeScale(NSEC_PER_SEC)))
        self.pauseIfNeeded()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        if let playerItem = player?.currentItem {
            playerItem.removeObserver(self, forKeyPath: PlayerNotification.bufferEmpty.description)
            playerItem.removeObserver(self, forKeyPath: PlayerNotification.bufferKeepUp.description)
            playerItem.removeObserver(self, forKeyPath: PlayerNotification.bufferFull.description)
            
        }
    }
}
extension AppPlayer {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayerItem {
            switch keyPath {
            case PlayerNotification.bufferEmpty.description:
                setPlayerState(state: .buffering)

            case PlayerNotification.bufferKeepUp.description:
                setPlayerState(state: .playing)

            case PlayerNotification.bufferFull.description:
                setPlayerState(state: .playing)
            default :
                break
            }
        }
    }
    
    func setPlayerState(state : AppPlayerState) {
        self.playerState =  state
       listenToPlayerState?(state)
    }
    
    
}
