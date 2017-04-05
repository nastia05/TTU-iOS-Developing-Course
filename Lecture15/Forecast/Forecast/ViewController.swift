//
//  ViewController.swift
//  Forecast
//
//  Created by nastia on 05/04/2017.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		loadImage()
	}
	
	func loadImage() {
		
		
		let url = URL(string: "http://media.mnn.com/assets/images/2015/11/red-ruffed-lemur.jpg.838x0_q80.jpg")!
		let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
			guard error == nil else {
				return
			}
			
			let image = UIImage(data: data!)
			DispatchQueue.main.async { [weak self] in
				self?.imageView.image = image
			}
		})
		
		dataTask.resume()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

