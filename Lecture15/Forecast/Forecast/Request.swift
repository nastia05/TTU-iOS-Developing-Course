//
//  Request.swift
//  Forecast
//
//  Created by nastia on 05/04/2017.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import Foundation

struct WeatherRequest {
	
	static let apiUrlString = "https://query.yahooapis.com/v1/public/yql"
	
	let cityName: String
	let unit: Unit
	
	init(cityName: String, unit: Unit = .celcius) {
		self.cityName = cityName
		self.unit = unit
	}
	
	enum Unit: String {
		case celcius = "c", farenheit = "f"
	}
	
	var request: URLRequest {
		let urlString = WeatherRequest.apiUrlString + queryString()
		let url = URL(string: urlString)!
		return URLRequest(url: url)
	}
	
	func queryString() -> String {
		let query = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(cityName)\") and u=\"\(unit.rawValue)\""
		let result = parametersString(parameters: [Parameter.query.rawValue : query, Parameter.format.rawValue : "json"])
		return result
		
	}
	
	func parametersString(parameters: [String : String]) -> String {
		var keyValues = [String]()
		for (key, value) in parameters {
			let keyValue = key + "=" + value
			let resultKeyValue = keyValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
			keyValues.append(resultKeyValue)
		}
		return "?\(keyValues.joined(separator: "&"))"
	}
	
	enum Parameter: String {
		case query = "q", format
	}
}
