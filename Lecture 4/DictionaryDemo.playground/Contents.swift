//  Functional dictionary

//  Functions are just regular types:

//  to create a new Dictionary, you have
var testDictionary: [String : ((Double, Double) -> Double)] = ["+" : { lhs, rhs in lhs + rhs}]


//  to add value for key:
testDictionary["-"] = { lhs, rhs in
    lhs - rhs
}

//  to update/add
testDictionary.updateValue({ $0 * $1 }, forKey: "*")

//  to remove, not big deal if not exists:
testDictionary.removeValue(forKey: "1234")
//  or
testDictionary["2345"] = nil

//  to enumerate through
for (key, value) in testDictionary {
    print("\(key) is \(value)")
}




