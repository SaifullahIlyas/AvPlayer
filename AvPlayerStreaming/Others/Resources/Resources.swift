//
// Resources.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import Foundation

class Resources  {
    static let strings  = StringResources()
}
class StringResources {
 let titlePlay = "Play"
 let titlePause = "Pause"
 let titleAudioSubTitle = "Audio/SubTitle"
 let titleDone = "Done"
 let videoUrl = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"
let stringNotificationPlaybackBufferEmpty = "playbackBufferEmpty"
let   stringNotificationPlaybackLikelyToKeepUp = "playbackLikelyToKeepUp"
let   stringNotificationPlaybackBufferFull = "playbackBufferFull"

}

enum StoryBoardIdentifier : CustomStringConvertible {
    case playerVC
    case subTitleVC
    var description: String {
        switch self {
        case .playerVC:
            return "PlayerVC"
        case .subTitleVC:
            return "SubTitleVC"
        }
    }
}
