//
//  ViewController.swift
//  TestApplication
//
//  Created by nastia on 23.11.16.
//  Copyright © 2016 Anastasiia Soboleva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	/*
		1. Do you remember why these outlets are weak?
		2. Try to guess why these outlets are optional.
	*/
	@IBOutlet weak var firstNameTextField: UITextField!
	
	@IBOutlet weak var secondNameTExtField: UITextField!
	
	@IBOutlet weak var nextButton: UIButton!
	
	var person: Person? {
		didSet {
			nextButton.isEnabled = person != nil
		}
	}
	
	@IBAction func textChanged(_ sender: UITextField) {
		
		/*
		NB Person is a structure in this example, that is why when we write
			person.firstName = firstNameTextField.text
		then a completely new instance of a Person is created. So this is equal to write just
			person = Person(firstName: firstNameTextField.text, secondName: secondNameTExtField.text).
		
		But if a Person was a class and we wrote
			person.firstName = firstNameTextField.text
		then there would be no callback in didSet because the reference would be the same.

		*/
		
		person = Person(firstName: firstNameTextField.text, secondName: secondNameTExtField.text)
		
	}
	
	
	
}

