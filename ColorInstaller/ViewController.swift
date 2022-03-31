//
//  ViewController.swift
//  ColorInstaller
//
//  Created by Kislov Vadim on 31.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentColorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentColorView.layer.cornerRadius = 10

        redSlider.value = getRandomColorHue()
        greenSlider.value = getRandomColorHue()
        blueSlider.value = getRandomColorHue()
        
        setColorLabelFor(sliders: redSlider, greenSlider, blueSlider)
        
        setViewColor()
    }

    @IBAction func onChangeSlider(_ sender: UISlider) {
        setViewColor()
        
        setColorLabelFor(sliders: sender)
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
