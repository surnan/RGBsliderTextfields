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
        let myAlertController = UIAlertController(title: "!! INVALID INPUT !!", message: "Values from 0 to 255", preferredStyle: .alert)
        myAlertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        guard let temp = Int(sender.text!), temp >= 0 && temp <= 255 else {
            print("Triggered")
            sender.text = String(oldTextfieldValue)
            present(myAlertController, animated: true, completion: nil)
            return
        }
        
        var destinationSlider = UISlider()
 
        switch sender {
        case redTextField: destinationSlider = redSlider; updateResultView(color: .red, magnitude: CGFloat(Int(sender.text!)!))
        case greenTextField:  destinationSlider = greenSlider; updateResultView(color: .green, magnitude: CGFloat(Int(sender.text!)!))
        case blueTextField:  destinationSlider = blueSlider; updateResultView(color: .blue, magnitude: CGFloat(Int(sender.text!)!))
        default:
            print("Invalid Slider Chosen")
        }
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
//    
//    @objc func buttonPressed(sender: UIButton){
//        let tempRed = resultView.backgroundColor?.rValue ?? 0.0
//        let tempBlue = resultView.backgroundColor?.bValue ?? 0.0
//        let tempGreen = resultView.backgroundColor?.gValue ?? 0.0
//        print("R = \(tempRed) .... G = \(tempGreen) .... B = \(tempBlue)")
//    }
}

extension UIColor {
    var rValue: CGFloat{ return CIColor(color: self).red }
    var gValue: CGFloat{ return CIColor(color: self).green }
    var bValue: CGFloat{ return CIColor(color: self).blue }
    var aValue: CGFloat{ return CIColor(color: self).alpha }
}
