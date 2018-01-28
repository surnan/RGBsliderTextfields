//
//  other stuff.swift
//  rgbSliderGUI
//
//  Created by admin on 1/24/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class Linx {
    let color : UIColor
    var cValue: Float {
        didSet {
            self.slider.setValue(cValue, animated: true)
            self.textField.placeholder = String(cValue)
        }
    }
    var slider  = UISlider()
    var textField = UITextField()
    
    init(color: UIColor) {
        self.color = color
        self.cValue = 0
        
        initSlider()
        initTextField()
    }
    
    
    func initSlider(){
        self.slider.minimumValue = 0.0
        self.slider.maximumValue = 255.0
        self.slider.thumbTintColor = self.color
        self.slider.isContinuous = true
        self.slider.minimumTrackTintColor = .white
        self.slider.maximumTrackTintColor = self.color
        self.slider.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.slider.addTarget(self, action: #selector(sliderChanged(sender:)), for: .valueChanged)
    }
    
    func initTextField(){
        self.textField.backgroundColor = .yellow
        self.textField.placeholder = "Hello World"
        self.textField.keyboardType = .numberPad
        self.textField.clearButtonMode = .whileEditing
        self.textField.clearsOnBeginEditing = true
        
//        self.textField.delegate = self
        
//        self.textField.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingDidEnd)
        
    }
    
    //Because I wanted @objc in Linx, I had to convert STRUCT to CLASS
    @objc func sliderChanged(sender: UISlider){
    
        print("SLIDER CHANGED")
    }

    @objc func textFieldChanged(sender: UITextField){
        print("TEXTFIELD CHANGED")
    }
}



