//
//  SimplePlayerController.swift
//  StudySwift
//
//  Created by songbiwen on 2017/2/7.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit
import AVFoundation

class SimplePlayerController: UIViewController {
    var musicPlayer:AVAudioPlayer!;
    
    //播放进度
    var progressSlider:UISlider?;
    
    //播放按钮
    var playButton:UIButton?;
    
    //暂停按钮
    var pauseButton:UIButton?;
    
    //声音进度条
    var voiceSlider:UISlider?;
    
    //定时器
    var timer:Timer?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI();
        
        self.view.backgroundColor = UIColor.white;
        let filePath = Bundle.main.path(forResource: "林俊杰-修炼爱情", ofType: "mp3");
        
        let myUrl = URL(fileURLWithPath: filePath!);
        

        musicPlayer = try? AVAudioPlayer(contentsOf: myUrl)
        musicPlayer.prepareToPlay();
    }

    func setupUI() {
        
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width;
        let margin: CGFloat = 20;
        let width:CGFloat = maxWidth - 2 * margin;
        let height:CGFloat = 40;
        
        //进度条初始化
        progressSlider = UISlider(frame:CGRect(x: margin, y: 100, width: width , height: height));
        progressSlider?.minimumValue = 0;
        progressSlider?.maximumValue = 1.0;
        progressSlider?.addTarget(self, action: #selector(didProgressChanged(sender:)), for: UIControlEvents.valueChanged);
        self.view.addSubview(progressSlider!);
        
        //播放按钮初始化
        playButton = UIButton(frame:CGRect(x: margin, y: ((progressSlider?.frame.origin.y)! + (progressSlider?.frame.size.height)! + margin), width:100, height:height));
        playButton?.backgroundColor = UIColor.brown;
        playButton?.setTitle("播放", for: UIControlState.normal);
        playButton?.addTarget(self, action: #selector(didPlayButtonClicked(sender:)), for: UIControlEvents.touchUpInside);
        self.view.addSubview(playButton!);
        
        //暂停按钮初始化
        pauseButton = UIButton(frame:CGRect(x: (maxWidth - margin - 100), y:(playButton?.frame.origin.y)!, width:100, height:height));
        pauseButton?.backgroundColor = UIColor.brown;
        pauseButton?.setTitle("暂停", for: UIControlState.normal);
        pauseButton?.addTarget(self, action: #selector(didPauseButtonClicked(sender:)), for: UIControlEvents.touchUpInside);
        self.view.addSubview(pauseButton!);
        
        //声音进度条初始化
        voiceSlider = UISlider(frame:CGRect(x: margin, y: ((playButton?.frame.origin.y)! + (playButton?.frame.size.height)! + margin), width:width, height:height));
        voiceSlider?.minimumValue = 0;
        voiceSlider?.maximumValue = 1;
        voiceSlider?.addTarget(self, action: #selector(didVoiceSliderChanged(sender:)), for: UIControlEvents.valueChanged);
        self.view.addSubview(voiceSlider!);
    }
    
    //播放进度改变
    func didProgressChanged(sender:UISlider) {
        musicPlayer.currentTime = musicPlayer.duration * TimeInterval(sender.value);
    }
    
    //播放
    func didPlayButtonClicked(sender:UIButton) {
        
        if !musicPlayer.isPlaying {
            musicPlayer.play();
            voiceSlider?.value = musicPlayer.volume;
            
            if timer != nil {
                timer?.invalidate();
                timer = nil;
            }
            //初始化定时器
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeProgressSlider), userInfo: nil, repeats: true);
            timer?.fire();
        };
    }
    
    func changeProgressSlider() {
        progressSlider?.value = Float(musicPlayer.currentTime) / Float(musicPlayer.duration);
    }
    
    //暂停
    func didPauseButtonClicked(sender:UIButton) {
        musicPlayer.pause();
        timer?.invalidate();
    }
    
    
    //声音进度
    func didVoiceSliderChanged(sender:UISlider) {
        musicPlayer.volume = sender.value;
    }
}
