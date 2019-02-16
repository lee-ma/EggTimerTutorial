//
//  PrefsViewController.swift
//  EggTimer
//
//  Created by Lee Ma on 2019-02-16.
//  Copyright © 2019 Lee Ma. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {

    @IBOutlet weak var presetsPopup: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var customTextField: NSTextField!
    
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showExistingPrefs()
    }
    
    func showExistingPrefs() {
        
        let selectedTimeInMinutes = Int(prefs.selectedTime) / 60
        
        presetsPopup.selectItem(withTitle: "Custom")
        customSlider.isEnabled = true
        
        for item in presetsPopup.itemArray {
            
            if item.tag == selectedTimeInMinutes {
                
                presetsPopup.select(item)
                customSlider.isEnabled = false
                break
            }
        }
        
        customSlider.integerValue = selectedTimeInMinutes
        showSliderValueAsText()
    }
    
    func showSliderValueAsText() {
        
        let newTimerDuration = customSlider.integerValue
        let minutesDescription = (newTimerDuration == 1) ? "minute" : "minutes"
        
        customTextField.stringValue = "\(newTimerDuration) \(minutesDescription)"
    }
    
    func saveNewPrefs() {
        prefs.selectedTime = customSlider.doubleValue * 60
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PrefsChanged"), object: nil)
    }
    
    @IBAction func popupValueChanged(_ sender: NSPopUpButton) {
        
        if sender.selectedItem?.title == "Custom" {
            
            customSlider.isEnabled = true
            return
        }
        
        let newTimerDuration = sender.selectedTag()
        customSlider.integerValue = newTimerDuration
        showSliderValueAsText()
        customSlider.isEnabled = true
    }
    
    @IBAction func sliderValueChanged(_ sender: NSSlider) {
        
        showSliderValueAsText()
    }
    
    @IBAction func onCancelButtonClick(_ sender: Any) {
        
        view.window?.close()
    }
    
    @IBAction func onOkButtonClick(_ sender: Any) {
        
        saveNewPrefs()
        view.window?.close()
    }
}
