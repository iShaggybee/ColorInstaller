//
//  SettingsViewController.swift
//  ColorInstaller
//
//  Created by Kislov Vadim on 31.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var currentColorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    var backgroundColor: UIColor!
    
    var delegate: WelcomeViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentColorView.layer.cornerRadius = 10
        
        (redSlider.value, greenSlider.value, blueSlider.value) = backgroundColor.rgb

        setColorLabelFor(sliders: redSlider, greenSlider, blueSlider)
        
        setViewColor()
    }

    @IBAction func onChangeSlider(_ sender: UISlider) {
        setViewColor()
        
        setColorLabelFor(sliders: sender)
    }
    
    @IBAction func onSaveColor() {
        delegate.setBackgroundColor(currentColorView.backgroundColor)
        
        dismiss(animated: true)
    }
    
    private func setViewColor() {
        currentColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setColorLabelFor(sliders: UISlider...) {
        for slider in sliders {
            switch slider {
            case redSlider:
                redValueLabel.text = sliderValueFormatter(redSlider.value)
            case greenSlider:
                greenValueLabel.text = sliderValueFormatter(greenSlider.value)
            default:
                blueValueLabel.text = sliderValueFormatter(blueSlider.value)
            }
        }
    }
    
    private func getRandomColorHue() -> Float {
        return round(Float.random(in: 0...1) * 100) / 100
    }
    
    private func sliderValueFormatter(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
}

extension UIColor {
    var rgb: (red: Float, green: Float, blue: Float) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (Float(red), Float(green), Float(blue))
    }
}
