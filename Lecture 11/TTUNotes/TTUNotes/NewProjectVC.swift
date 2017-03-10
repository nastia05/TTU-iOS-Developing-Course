//
//  NotesTVC.swift
//  TTUNotes
//
//  Created by Anastasiia Soboleva on 08.03.17.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import UIKit

class NewProjectVC: UIViewController {
	
	@IBOutlet weak var textField: UITextField!
	
	@IBAction func donePressed(_ sender: UIBarButtonItem) {
		let text = textField.text ?? "Default"
		
		let project = Project(context: container.viewContext)
		project.creationDate = NSDate()
		project.name = text
		try? container.viewContext.save()
		
		dismiss(animated: true, completion: nil)
	}
}
