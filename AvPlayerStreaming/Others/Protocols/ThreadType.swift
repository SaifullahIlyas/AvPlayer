//
//  ThreadType.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import Foundation
protocol ThreadType : AnyObject{
    
}
extension ThreadType {
    func ruOnMain(code : @escaping (()->Void)) {
        DispatchQueue.main.async {
            code()
        }
    }
}
