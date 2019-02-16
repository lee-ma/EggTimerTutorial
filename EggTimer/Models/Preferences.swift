//
//  Preferences.swift
//  EggTimer
//
//  Created by Lee Ma on 2019-02-16.
//  Copyright © 2019 Lee Ma. All rights reserved.
//

import Foundation

struct Preferences {
    
    var selectedTime: TimeInterval {
        
        get {
            
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            
            return savedTime
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
