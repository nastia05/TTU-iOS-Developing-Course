//  Closure = function + context
//  context is everything that closure uses inside which is defined outside

let integer = 10
let string = "String"

//  this closure takes Void and returns Void; and grabbs `integer` and `string`
let closure: (Void) -> Void = {
    print("integer is \(integer), string is \(string)")
}

//  we can call it later if we want, just like a function:
closure() /* prints "integer is 10, string is String" */

//  we can copy it
let closureCopy = closure

//  we can treat (Void) -> Void as a regular type and do everything we can do with a type

//  closure can take argument and return something
//  note that we have a list of arguments after `{` and `in` keyword
let intToStringConverter: (Int) -> String = { int in
    return "\(int)"
}

intToStringConverter(10)

//  we can use any name in an argument list, but if we want to be short we can refer to argument via $0, $1, $2
let summ: (Int, Int) -> Int = {
    return $0 + $1
}
//  note that in this case we don't have to write `in` keyword

//  Swift is smart enough to know that if closure has 1-line expression of expecting type, we don't have to write `return`
let betterSumm: (Int, Int) -> Int = { $0 + $1 }

betterSumm(110, 130)

//  closure will be capturing everything by reference even value types
var integerValue = 20
let printy: (Void) -> Void = {
    print(integerValue)
}

//  Little test to show how it works
printy()    /* prints "20" */
integerValue += 1
printy()    /* prints "21" */

//  to say that closure should copy value type by value we should specify a capture list
let capturingPrinty: (Void) -> Void = { [integerValue] in
    print(integerValue)
}

//  Little test to show how it is working
capturingPrinty() /* prints "21" */
integerValue += 1
capturingPrinty() /* prints "21" */


//  Worse case is reference type because we can capture it strongly and weakly
class A {
}

let a = A()

//  This closure holds strong reference to an `a` instance of `A`
let strongCapturingClosure: (Void) -> Void = {
    _ = a
}

//  In most cases strong reference is not what we want because we can have such retain cycle:
class B {
    var badClosure: ((Void) -> Void)?
    
    //  by just initialising the instance we create retain cycle
    init() {
        
        badClosure = {
            // do something with self
            _ = self
        }
    }
}

//  To make weak capturing we can do:
let weakCapturingClosure: (Void) -> Void = { [weak a] in
    // if `a` was deinitialized before calling closure, a value inside of the closure will be nil
}

//  If we don't want to increase reference count, but don't expect closure to be called after
let unownedCapturingClosure: (Void) -> Void = { [unowned a] in
    // it will crash application if using a inside of the closure while a was deinitialized
}


/// Trailing closures
//  To simplyfy using closures in functions we can drop argument name if it is a closure
func trailingFunction(closure: (Int) -> Int) {
    closure(10)
}

trailingFunction(closure: { integer in
    return integer * 2
})

trailingFunction { $0 * 2 }




