//
//  PasswordGenerator.swift
//  Passworder
//
//  Created by nastia on 21.12.16.
//  Copyright © 2016 Anastasiia Soboleva. All rights reserved.
//

import Foundation

fileprivate let elements = ["qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM", "1234567890", "🤓😂👻😉😜😎😈👍🎃"]

struct CharType: OptionSet {
	let rawValue: Int
	
	static let letters = CharType(rawValue: 1 << 0)
	static let numbers = CharType(rawValue: 1 << 1)
	static let symbols = CharType(rawValue: 1 << 2)
	
	var toGeneratePasswordFrom: String {
		var result = ""
		if contains(.letters) {
			result += elements[0]
		}
		if contains(.numbers) {
			result += elements[1]
		}
		if contains(.symbols) {
			result += elements[2]
		}
		return result
	}
	
	mutating func updateSetting(with type: CharType, include: Bool) {
		if include {
			insert(type)
		} else {
			remove(type)
		}
	}
}

class PasswordGenerator {
	
	weak var passwordDelegate: PasswordGeneratorProtocol?
	
	var settings = CharType.letters {
		didSet {
			passwordDelegate?.passwordGeneratorDidUpdateSettings(passwordGenerator: self)
		}
	}
	
	var length = 8 {
		didSet {
			passwordDelegate?.passwordGeneratorDidUpdateSettings(passwordGenerator: self)
		}
	}
	
	func generate() -> String {
		var password = ""
		for _ in 0..<length {
			let passwordToGenerate = settings.toGeneratePasswordFrom
			let randomIndex = arc4random_uniform(UInt32(passwordToGenerate.characters.count))
			let element = passwordToGenerate.characters[passwordToGenerate.index(passwordToGenerate.startIndex, offsetBy: String.IndexDistance(randomIndex))]
			password += String(element)
		}
		return password
	}
	
}

protocol PasswordGeneratorProtocol: NSObjectProtocol {
	
	func passwordGeneratorDidUpdateSettings(passwordGenerator: PasswordGenerator)
}
