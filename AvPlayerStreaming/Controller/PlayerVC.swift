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
        button.setTitle(Resources.strings.titlePlay, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(togglePlayPause(_:)), for: .touchUpInside)
        return button
    }()
    lazy var  audioSubTitleBtn : UIButton = {
        let button = UIButton.init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Resources.strings.titleAudioSubTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(toggleAudioSubtitle(_:)), for: .touchUpInside)
        return button
    }()
    lazy var seekbar : UISlider = {
       let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(seekBarChange(_:)), for: .valueChanged)
       return slider
        
    }()
    lazy var playerViewConstraints  : [NSLayoutConstraint] = {
       [NSLayoutConstraint(item: self.playerView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),NSLayoutConstraint(item: self.playerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),NSLayoutConstraint(item: self.playerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),NSLayoutConstraint(item: self.playerView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)]
    }()
    lazy var controlViewConstraints : [NSLayoutConstraint] = {
        [NSLayoutConstraint(item: self.controlView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),NSLayoutConstraint(item: self.controlView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),NSLayoutConstraint(item: self.controlView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),NSLayoutConstraint(item: self.controlView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.25, constant: 0)]
    }()
    lazy var togglePlayPauseConstraint : [NSLayoutConstraint] = {
        [NSLayoutConstraint.init(item: playPauseBtn, attribute: .centerX, relatedBy: .equal, toItem: controlView, attribute: .centerX, multiplier: 1, constant: 0), NSLayoutConstraint.init(item: playPauseBtn, attribute: .centerY, relatedBy: .equal, toItem: controlView, attribute: .centerY, multiplier: 1, constant: 0)]
    }()
    lazy var subTitleBtnConstraint : [NSLayoutConstraint] = {
        [NSLayoutConstraint.init(item: audioSubTitleBtn, attribute: .centerX, relatedBy: .equal, toItem:controlView, attribute: .centerX, multiplier: 1.5, constant: 0), NSLayoutConstraint.init(item: audioSubTitleBtn, attribute: .centerY, relatedBy: .equal, toItem: controlView, attribute: .centerY, multiplier: 1, constant: 0)]
        
    }()
    lazy var seekBarConstraint  : [NSLayoutConstraint] = {
        [NSLayoutConstraint(item: seekbar, attribute: .leading, relatedBy: .equal, toItem: controlView, attribute: .leading, multiplier: 1, constant: 0),NSLayoutConstraint(item: seekbar, attribute: .top, relatedBy: .equal, toItem: controlView, attribute: .top, multiplier: 1, constant: 10),NSLayoutConstraint(item: seekbar, attribute: .trailing, relatedBy: .equal, toItem: controlView, attribute: .trailing, multiplier: 1, constant: 0)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViewViews()
        addConstrains()

        // Do any additional setup after loading the view.
    }
    func addSubViewViews(){
        self.view.addSubview(playerView)
        self.view.addSubview(controlView)
        controlView.addSubview(playPauseBtn)
        controlView.addSubview(audioSubTitleBtn)
        controlView.addSubview(seekbar)
    }
    func addConstrains (){
        NSLayoutConstraint.activate(playerViewConstraints)
        NSLayoutConstraint.activate(controlViewConstraints)
        NSLayoutConstraint.activate(togglePlayPauseConstraint)
        NSLayoutConstraint.activate(subTitleBtnConstraint)
        NSLayoutConstraint.activate(seekBarConstraint)
        
        
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
