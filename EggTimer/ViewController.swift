//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var time = 0
    var totalTime = 0
    
    var player: AVAudioPlayer?
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressbar: NSLayoutConstraint!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        progressBar.progress = 0.0
        timer?.invalidate()
        
        titleLabel.text = hardness
        
        time = eggTimes[hardness]!;
        
        totalTime = time
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(processTimer), userInfo: nil, repeats: true)    }
    
    var timer : Timer?
    
    func killTimer() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player!.play()
        } catch {
            print ("There is an issue with this code!")
        }
        timer?.invalidate()
        titleLabel.text = "DONE!"
        timer = nil
    }
    
    @objc func processTimer() {
        print(time)
        time -= 1
        let currentTimePassed = totalTime - time
        print(currentTimePassed)
        let percentage = Float(currentTimePassed) / Float(totalTime)
        print(percentage)
        
        progressBar.progress = Float(percentage)
        if(time == 0){
            killTimer()
        }
    }
}
