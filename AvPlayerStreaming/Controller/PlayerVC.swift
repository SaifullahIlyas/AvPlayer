//
//  PlayerVC.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import UIKit

class PlayerVC: BaseVC {
    lazy var appPlayer : AppPlayer = {
        return AppPlayer()
    }()
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appPlayer.setUpPlayerWithUrl(url: URL(string: Resources.strings.videoUrl)!, into: playerView)
        appPlayer.addPlayerTimeChangeObserver()
        appPlayer.timerChangeValue = {[weak self ] value in
            self?.seekbar.minimumValue = 0
            if let duration = self?.appPlayer.getMediaDuration() {
                self?.seekbar.maximumValue = Float(duration.isNaN ? 0 : duration)
            }
            self?.seekbar.value = value
        }
        appPlayer.playIfNeeded()
        playPauseBtn.setTitle(Resources.strings.titlePause, for: .normal)
        appPlayer.didFinishedPlaying = {[weak self] in
            self?.seekbar.value = 0
            self?.appPlayer.reset()
            self?.playPauseBtn.setTitle(Resources.strings.titlePlay, for: .normal)
        }
        
    }
    @objc func togglePlayPause(_ sender : Any) {
        if appPlayer.playerState == .playing {
            appPlayer.pauseIfNeeded()
            playPauseBtn.setTitle(Resources.strings.titlePlay, for: .normal)
        }
        else {
            appPlayer.playIfNeeded()
            playPauseBtn.setTitle(Resources.strings.titlePause, for: .normal)
            
        }
        
    }
    @objc func toggleAudioSubtitle(_ sender : Any) {
        guard let subTitleVc = storyboard?.instantiateViewController(identifier: StoryBoardIdentifier.subTitleVC.description) as? SubTitleVC else {
            return
        }
        subTitleVc.appPlayer = appPlayer
        present(subTitleVc, animated: true, completion: nil)
        
    }
    @objc func seekBarChange(_ sender : UISlider){
        //in seconds
        appPlayer.seekTo(time: Int64(sender.value * 1000))
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
