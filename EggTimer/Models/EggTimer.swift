//
//  EggTimer.swift
//  EggTimer
//
//  Created by Lee Ma on 2019-02-16.
//  Copyright © 2019 Lee Ma. All rights reserved.
//

import Foundation

class EggTimer {
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 360
    var elapsedTime: TimeInterval = 0
    
    var isStopped: Bool {
        
        return timer == nil && elapsedTime == 0
    }
    var isPaused: Bool {
        
        return timer == nil && elapsedTime > 0
    }
    
    var delegate: EggTimerProtocol?
    
    func startTimer() {
        
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )
        
        timerAction()
    }
    
    func resumeTimer() {
        
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )
        
        timerAction()
    }
    
    func stopTimer() {
        
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    
    func resetTimer() {
        
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        duration = 360
        elapsedTime = 0
        
        timerAction()
    }
    
    @objc dynamic func timerAction() {
        
        guard let startTime = startTime else {
            
            return
        }
        
        // timeIntervalSinceNow is a negative number in this case since startTime
        // is earlier than now. Minus sign makes elapsedTime positive
        elapsedTime = -startTime.timeIntervalSinceNow
        
        let secondsRemaining = (duration - elapsedTime).rounded()
        
        if secondsRemaining <= 0 {
            
            resetTimer()
            delegate?.timerHasFinished(self)
        } else {
            
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
}

protocol EggTimerProtocol {
    
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval)
    func timerHasFinished(_ timer: EggTimer)
}
