//
//  WeatherVC.swift
//  Forecast
//
//  Created by nastia on 05/04/2017.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

	var weather: Weather? {
		didSet {
			tempLabel.text = weather?.temperature
			descriptionLabel.text = weather?.description
		}
	}
	
	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadWeather()
	}
	
	func loadWeather() {
		
		let cityName = "Tallinn"
		cityNameLabel.text = cityName
		let weatherRequest = WeatherRequest(cityName: cityName)
		
		let dataTask = URLSession.shared.dataTask(with: weatherRequest.request, completionHandler: { (data, response, error) in
			
			guard error == nil else {
				return
			}
			
			let parsedData = try? JSONSerialization.jsonObject(with: data!, options: [])
			guard let parsedNilData = parsedData, let weather = Weather(parsedData: parsedNilData) else {
				return
			}
			
			DispatchQueue.main.async { [weak self] in
				self?.weather = weather
			}
			
		})
		dataTask.resume()
		
	}

}

