//
//  ExtensionTwo.swift
//  rgbSliderGUI
//
//  Created by admin on 1/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension ViewController {

    
    @objc func textFieldChanged(sender: UITextField){
        var destinationSlider = UISlider()
        
        switch sender {
        case redTextField: destinationSlider = redSlider; updateResultView(color: .red, magnitude: CGFloat(Int(sender.text!)!))
        case greenTextField:  destinationSlider = greenSlider; updateResultView(color: .green, magnitude: CGFloat(Int(sender.text!)!))
        case blueTextField:  destinationSlider = blueSlider; updateResultView(color: .blue, magnitude: CGFloat(Int(sender.text!)!))
        default:
            print("Invalid Slider Chosen")
        }
        
//        sender.resignFirstResponder()
        destinationSlider.value = Float(sender.text!) ?? 0.0
    }

    @objc func sliderChanged(sender: UISlider){
        var destinationTextField = UITextField()
        switch sender {
        case redSlider: destinationTextField = redTextField; updateResultView(color: .red, magnitude: CGFloat(Int(sender.value)))
        case greenSlider:  destinationTextField = greenTextField; updateResultView(color: .green, magnitude: CGFloat(Int(sender.value)))
        case blueSlider:  destinationTextField = blueTextField; updateResultView(color: .blue, magnitude: CGFloat(Int(sender.value)))
        default:
            print("Invalid Slider Chosen")
        }
        destinationTextField.text = String(Int(sender.value))
    }
    
    @objc func buttonPressed(sender: UIButton){
//        print("!!!!BUTTON WAS JUST PRESSED!!!!")
        let tempRed = resultView.backgroundColor?.rValue ?? 0.0
        let tempBlue = resultView.backgroundColor?.bValue ?? 0.0
        let tempGreen = resultView.backgroundColor?.gValue ?? 0.0
        print("R = \(tempRed) .... G = \(tempGreen) .... B = \(tempBlue)")
    }
}

extension UIColor {
    var rValue: CGFloat{ return CIColor(color: self).red }
    var gValue: CGFloat{ return CIColor(color: self).green }
    var bValue: CGFloat{ return CIColor(color: self).blue }
    var aValue: CGFloat{ return CIColor(color: self).alpha }
}
