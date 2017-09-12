//
//  AnimationsViewController.swift
//  VCUIKit
//
//  Created by Vitor Cesco on 12/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import VCUIKit
import UIKit

struct Animation {
    let name: String
    let duration: Float
}

class AnimationsViewController: UIViewController {
    let animations: [Animation] = [
        Animation(name: "Shake", duration: 0.5),
        Animation(name: "Bounce", duration: 0.5),
        Animation(name: "Grow", duration: 0.5),
        Animation(name: "Shrink", duration: 0.5),
        Animation(name: "Swing", duration: 0.35)
    ]
    
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var multiplierSlider: UISlider!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var multiplierLabel: UILabel!
    
    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var animationPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func multiplierSliderValueChanged(_ sender: Any) {
        self.updateLabels()
    }
    @IBAction func durationSliderValueChanged(_ sender: Any) {
        self.updateLabels()
    }
    @IBAction func animateButtonPressed(_ sender: Any) {
        switch self.animationPickerView.selectedRow(inComponent: 0) {
        case 0:
            self.testView.shake(duration: self.durationSlider.value, multiplier: self.multiplierSlider.value)
        case 1:
            self.testView.bounce(duration: self.durationSlider.value, multiplier: self.multiplierSlider.value)
        case 2:
            self.testView.grow(duration: self.durationSlider.value, multiplier: self.multiplierSlider.value)
        case 3:
            self.testView.shrink(duration: self.durationSlider.value, multiplier: self.multiplierSlider.value)
        case 4:
            self.testView.swing(duration: self.durationSlider.value, multiplier: self.multiplierSlider.value)
        default:
            break
        }
    }
    
    func updateLabels() {
        self.multiplierLabel.text = "Multiplier: " + String(self.multiplierSlider.value)
        self.durationLabel.text = "Duration: " + String(self.durationSlider.value)
    }
}

extension AnimationsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.animations.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.animations[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.durationSlider.value = self.animations[row].duration
        self.multiplierSlider.value = 1
        self.updateLabels()
    }
}

