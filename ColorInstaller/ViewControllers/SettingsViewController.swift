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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var backgroundColor: UIColor!
    
    var delegate: WelcomeViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentColorView.layer.cornerRadius = 10
        
        (redSlider.value, greenSlider.value, blueSlider.value) = backgroundColor.rgb
        
        setTextFields(redTextField, greenTextField, blueTextField)
        
        setLabelAndFieldFor(sliders: redSlider, greenSlider, blueSlider)
        
        setViewColor()
    }

    @IBAction func onChangeSlider(_ sender: UISlider) {
        setViewColor()
        
        setLabelAndFieldFor(sliders: sender)
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
    
    private func setLabelAndFieldFor(sliders: UISlider...) {
        for slider in sliders {
            switch slider {
            case redSlider:
                redValueLabel.text = floatValueFormatter(redSlider.value)
                redTextField.text = floatValueFormatter(redSlider.value)
            case greenSlider:
                greenValueLabel.text = floatValueFormatter(greenSlider.value)
                greenTextField.text = floatValueFormatter(greenSlider.value)
            default:
                blueValueLabel.text = floatValueFormatter(blueSlider.value)
                blueTextField.text = floatValueFormatter(blueSlider.value)
            }
        }
    }
    
    private func setSliderAndLabelFor(field: UITextField) {
        let text = field.text ?? "0"
        
        switch field {
        case redTextField:
            redSlider.value = Float(text) ?? 0
            redValueLabel.text = floatValueFormatter(redSlider.value)
        case greenTextField:
            greenSlider.value = Float(text) ?? 0
            greenValueLabel.text = floatValueFormatter(greenSlider.value)
        default:
            blueSlider.value = Float(text) ?? 0
            blueValueLabel.text = floatValueFormatter(blueSlider.value)
        }
    }

    private func floatValueFormatter(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
    
    private func setTextFields(_ textFields: UITextField...) {
        for textField in textFields {
            textField.delegate = self
            setKeyboardToolbar(for: textField)
        }
    }
    
    private func setKeyboardToolbar(for field: UITextField) {
        let bar = UIToolbar()
        let leftSpace = UIBarButtonItem(
                            barButtonSystemItem: .flexibleSpace,
                            target: nil,
                            action: nil
                        )
        let doneButton = UIBarButtonItem(
                            title: "Done",
                            style: .plain,
                            target: self,
                            action: #selector(tapDone)
                         )
        
        bar.items = [leftSpace, doneButton]
        bar.sizeToFit()

        field.inputAccessoryView = bar
    }
    
    @objc private func tapDone() {
        view.endEditing(true)
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

extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 4
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        
        if currentText.isEmpty {
            showAlert(title: "Error", message: "Text cannot be empty")
            return
        }
        
        guard let value = Double(currentText) else {
            showAlert(title: "Error", message: "Value must be numeric")
            return
        }
        
        if !(0...1.0).contains(value) {
            showAlert(title: "Error", message: "Value must be between 0 and 1")
            return
        }
        
        setSliderAndLabelFor(field: textField)
        
        setViewColor()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
