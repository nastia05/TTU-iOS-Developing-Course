//
//  Weather.swift
//  Forecast
//
//  Created by nastia on 05/04/2017.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import Foundation

struct Weather {
	
	let temperature: String
	let description: String
	
	init?(parsedData: Any) {
		
		let parsedDic = (parsedData as AnyObject)[ParameterKey.query.rawValue] as? [String : AnyObject]
		let results = parsedDic?[ParameterKey.results.rawValue] as? [String : AnyObject]
		let channel = results?[ParameterKey.channel.rawValue] as? [String : AnyObject]
		let item = channel?[ParameterKey.item.rawValue] as? [String : AnyObject]
		let condition = item?[ParameterKey.condition.rawValue] as? [String : String]
		guard let temp = condition?[ParameterKey.temp.rawValue], let text = condition?[ParameterKey.text.rawValue] else {
			return nil
		}
		
		temperature = temp
		description = text
		
	}
}

enum ParameterKey: String {
	case query, results, channel, item, condition, temp, text
}
