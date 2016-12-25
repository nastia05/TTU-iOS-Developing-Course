//
//  SettingsVC.swift
//  Passworder
//
//  Created by nastia on 21.12.16.
//  Copyright © 2016 Anastasiia Soboleva. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

	var passwordGenerator: PasswordGenerator!
	
	@IBOutlet weak var lengthLabel: UILabel!
	
	@IBOutlet weak var slider: UISlider!
	
	@IBOutlet weak var numberSwitch: UISwitch!
	
	@IBOutlet weak var symbolsSwitch: UISwitch!
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let length = Int(round(sender.value))
		passwordGenerator.length = length
		lengthLabel.text = String(length)
	}
	
	@IBAction func switchValueChanged(_ sender: UISwitch) {
		
		switch sender {
		case numberSwitch:
			passwordGenerator.settings.updateSetting(with: .numbers, include: sender.isOn)
		case symbolsSwitch:
			passwordGenerator.settings.updateSetting(with: .symbols, include: sender.isOn)
		default: break
		}
		
	}
	
	@IBAction func closePressed(_ sender: UIButton) {
		
		dismiss(animated: true, completion: nil)
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		lengthLabel.text = String(passwordGenerator.length)
		numberSwitch.isOn = passwordGenerator.settings.contains(.numbers)
		symbolsSwitch.isOn = passwordGenerator.settings.contains(.symbols)
		slider.value = Float(passwordGenerator.length)
	}
	
	

}
