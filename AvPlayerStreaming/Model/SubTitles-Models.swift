//
//  Models.swift
//  SubTitles-Models
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import Foundation
import  AVFoundation

class TrackType {
    var sectionType : SectionType? = nil
    var secTionGroup   : AVMediaSelectionGroup? = nil
    var items : [TrackDetail]? = nil
    
    
}
class TrackDetail {
   
    
    var isSeleced : Bool?
    var disPlayName : String?
    let option : AVMediaSelectionOption?
    init(isSeleced: Bool? = nil, disPlayName: String? = nil,option : AVMediaSelectionOption?) {
         self.isSeleced = isSeleced
         self.disPlayName = disPlayName
        self.option = option
     }
    
    
}
enum SectionType : CaseIterable{
    case Audio
    case subTitle
    var title : String {
        switch self {
        case .Audio:
          return  "Audio's"
        case .subTitle:
            return "SubTitle's"
            
        }
    }
    var cellIdentifier : String {
        switch self {
        default:
            return "TbInfoCell"
        }
    }
}
