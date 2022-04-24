//
//  WelcomeViewController.swift
//  ColorInstaller
//
//  Created by Kislov Vadim on 20.04.2022.
//

import UIKit

protocol WelcomeViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor?)
}

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }
        
        settingsVC.backgroundColor = view.backgroundColor
        settingsVC.delegate = self
    }
    
    private func getRandomColorHue() -> Float {
        round(Float.random(in: 0...1) * 100) / 100
    }
}

extension WelcomeViewController: WelcomeViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor? = nil) {
        view.backgroundColor = color != nil
                        ? color
                        : UIColor(
                            red: CGFloat(getRandomColorHue()),
                            green: CGFloat(getRandomColorHue()),
                            blue: CGFloat(getRandomColorHue()),
                            alpha: 1
                          )
    }
}
