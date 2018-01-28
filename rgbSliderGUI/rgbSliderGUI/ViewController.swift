//
//  ViewController.swift
//  rgbSliderGUI
//
//  Created by admin on 1/24/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redSlider = UISlider(); var redTextField = UITextField(); var redValue: Float = 0.0
    var blueSlider = UISlider(); var blueTextField = UITextField(); var blueValue: Float = 0.0
    var greenSlider = UISlider(); var greenTextField = UITextField(); var greenValue: Float = 0.0
    var resultView = UIView()
    var showNumbers = UIButton()
    var oldTextfieldValue = 0   //This value is used to rollback UITextfield value is input is not number between 0-255
    
    
    var regularConstraints = [NSLayoutConstraint]()
    var compactConstraints = [NSLayoutConstraint]()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        let sliderStack = setupSliderStack(allSliders: redSlider, blueSlider, greenSlider)
        let textfieldStack = setupTextFieldStack(allTextView: redTextField, blueTextField, greenTextField)
        resultView = setupResultView(resultView: resultView)
        showNumbers = setupShowNumbersButton(button: showNumbers)
        
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        textfieldStack.translatesAutoresizingMaskIntoConstraints = false
        resultView.translatesAutoresizingMaskIntoConstraints = false
        showNumbers.translatesAutoresizingMaskIntoConstraints = false
        
        setupAllGUI()
        sliderStack.axis = .vertical; textfieldStack.axis = .vertical
        sliderStack.alignment = .fill; textfieldStack.alignment = .fill
        sliderStack.spacing = 20; textfieldStack.spacing = 20

        blueTextField.delegate = self; greenTextField.delegate = self; redTextField.delegate = self
        self.view.addSubview(sliderStack); self.view.addSubview(textfieldStack); self.view.addSubview(resultView);
        
//        self.view.addSubview(showNumbers)
        
        sliderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sliderStack.centerYAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 150).isActive = true
        sliderStack.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        textfieldStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textfieldStack.topAnchor.constraint(equalTo: sliderStack.bottomAnchor, constant: 50).isActive = true
        
        resultView.topAnchor.constraint(equalTo: textfieldStack.bottomAnchor, constant: 50).isActive = true
        resultView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultView.leftAnchor.constraint(equalTo: view.readableContentGuide.leftAnchor).isActive = true
        resultView.rightAnchor.constraint(equalTo: view.readableContentGuide.rightAnchor).isActive = true
        resultView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -20).isActive = true

//        showNumbers.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor).isActive = true
//        showNumbers.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        //Check size class
        if traitCollection.horizontalSizeClass == .regular {
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
//            socialMediaView.axis = .horizontal
        } else {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
//            socialMediaView.axis = .vertical
        }
    }
    
    func setupShowNumbersButton(button: UIButton) -> UIButton{
         let temp = button
        temp.backgroundColor = UIColor.white
        temp.setTitle("SHOW NUMBERS", for: .normal)
        temp.setTitleColor(UIColor.black, for: .normal)
        temp.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return temp
    }
    
    
    func updateResultView(color: UIColor, magnitude: CGFloat){
  
        let ttempRed = CGFloat(Int(redTextField.text!)!)
        let ttempBlue = CGFloat(Int(blueTextField.text!)!)
        let ttempGreen = CGFloat(Int(greenTextField.text!)!)

       switch color {
        case UIColor.red: resultView.backgroundColor = UIColor(displayP3Red: magnitude/255, green: ttempGreen/255, blue: ttempBlue/255, alpha: 1.0)
        case UIColor.green: resultView.backgroundColor = UIColor(displayP3Red: ttempRed/255, green: magnitude/255, blue: ttempBlue/255, alpha: 1.0)
        case UIColor.blue: resultView.backgroundColor = UIColor(displayP3Red: ttempRed/255, green: ttempGreen/255, blue: magnitude/255, alpha: 1.0)
        default:
            print("BAD INPUT COLOR")
        }
    }
    
    
    func setupSliderStack(allSliders: UISlider...)-> UIStackView {
        let tempSliderStack = UIStackView()
        for temp in allSliders {
            tempSliderStack.addArrangedSubview(temp)
        }
        return tempSliderStack
    }
    
    func setupTextFieldStack(allTextView: UITextField...)-> UIStackView {
        let tempTextFieldStack = UIStackView()
        for temp in allTextView {
            tempTextFieldStack.addArrangedSubview(temp)
        }
        return tempTextFieldStack
    }

    func setupTextField(color: UIColor, textField: UITextField) -> UITextField {
        let temp = textField
        temp.textColor = color
        temp.backgroundColor = .white
        temp.text = "0"
        temp.textAlignment = .center
        temp.clearsOnInsertion = true
        
        temp.keyboardType = .numberPad
        temp.addTarget(self, action: #selector(textFieldChanged), for: .editingDidEnd)
        temp.widthAnchor.constraint(equalToConstant: 75).isActive = true
        return temp
    }

    func setupSliders(color: UIColor, slider: UISlider) -> UISlider {
        let temp = slider
        temp.isContinuous = true
        temp.minimumTrackTintColor = .white
        temp.maximumTrackTintColor = color
        temp.minimumValue = 0
        temp.maximumValue = 255
        temp.thumbTintColor = color
        temp.addTarget(self, action: #selector(sliderChanged(sender:)), for: .valueChanged)
        return temp
    }
    
    func setupAllGUI(){
        redSlider = setupSliders(color: .red, slider: redSlider)
        greenSlider = setupSliders(color: .green, slider: greenSlider)
        blueSlider = setupSliders(color: .blue, slider: blueSlider)
        redTextField = setupTextField(color: .red, textField: redTextField)
        blueTextField = setupTextField(color: .blue, textField: blueTextField)
        greenTextField = setupTextField(color: .green, textField: greenTextField)
    }
    
    func setupResultView(resultView: UIView) -> UIView{
        let tempView = UIView()
        tempView.backgroundColor = UIColor.black
        return tempView
    }
}



