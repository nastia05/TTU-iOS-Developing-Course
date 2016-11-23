//
//  Model.swift
//  TestApplication
//
//  Created by nastia on 23.11.16.
//  Copyright © 2016 Anastasiia Soboleva. All rights reserved.
//

import Foundation

struct Person {
	
	let firstName: String
	let secondName: String
	
	/*
		failable initialiser
	*/
	init?(firstName fn: String?, secondName sn: String?) {
		guard let fn = fn, let sn = sn, !fn.isEmpty, !sn.isEmpty else {
			return nil
		}
		firstName = fn
		secondName = sn
	}
}

