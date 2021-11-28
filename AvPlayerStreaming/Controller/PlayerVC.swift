//
//  PlayerVC.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import UIKit

class PlayerVC: BaseVC {
    lazy var playerView : UIView = {
       let view = UIView()
       view.backgroundColor = .black
      view.translatesAutoresizingMaskIntoConstraints = false
        
       return view
    }()
    lazy var controlView  :  UIView = {
     let view = UIView()
     view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
     return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(playerView)
        self.view.addSubview(controlView)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
