//
//  FindingViewController.swift
//  Code Adam
//
//  Created by 刘祥 on 3/23/19.
//  Copyright © 2019 xiangliu90. All rights reserved.
//

import UIKit

class FindingViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    var countdownTimer: Timer!
    var totalTime = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func StopFinding(_ sender: UIButton) {
        endTimer()
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "Time to call police \(timeFormatted(totalTime))"
        totalTime -= 1
        
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }

}
