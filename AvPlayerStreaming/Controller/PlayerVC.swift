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
    lazy  var playPauseBtn : UIButton  = {
        let button = UIButton.init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(togglePlayPause(_:)), for: .touchUpInside)
        return button
    }()
    lazy var  audioSubTitleBtn : UIButton = {
        let button = UIButton.init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleAudioSubtitle(_:)), for: .touchUpInside)
        return button
    }()
    lazy var seekbar : UISlider = {
       let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(seekBarChange(_:)), for: .valueChanged)
       return slider
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViewViews()

        // Do any additional setup after loading the view.
    }
    func addSubViewViews(){
        self.view.addSubview(playerView)
        self.view.addSubview(controlView)
        controlView.addSubview(playPauseBtn)
        controlView.addSubview(audioSubTitleBtn)
        controlView.addSubview(seekbar)
    }
    @objc func togglePlayPause(_ sender : Any) {
    }
    @objc func toggleAudioSubtitle(_ sender : Any) {}
    @objc func seekBarChange(_ sender : UISlider){}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
    */

}
