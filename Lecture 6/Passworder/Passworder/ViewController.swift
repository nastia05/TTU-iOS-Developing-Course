//
//  ViewController.swift
//  Passworder
//
//  Created by nastia on 21.12.16.
//  Copyright © 2016 Anastasiia Soboleva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PasswordGeneratorProtocol {
	
	let passwordGenerator = PasswordGenerator()
	
	@IBOutlet weak var passwordLabel: UILabel!
	
	@IBAction func generateButtonPressed(_ sender: UIButton) {
		updatePassword()
	}
	
	@IBAction func settingsPressed(_ sender: UIButton) {
		
		performSegue(withIdentifier: "toSettingsVCSID", sender: sender)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		passwordGenerator.passwordDelegate  = self
		updatePassword()
	}
	
	func updatePassword() {
		let password = passwordGenerator.generate()
		passwordLabel.text = password
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard segue.identifier == "toSettingsVCSID", let dvc = segue.destination as? SettingsVC else {
			return
		}
		
		dvc.passwordGenerator = passwordGenerator
	}
	
	//MARK: - PasswordGeneratorProtocol methods
	func passwordGeneratorDidUpdateSettings(passwordGenerator: PasswordGenerator) {
		updatePassword()
	}
	
}

