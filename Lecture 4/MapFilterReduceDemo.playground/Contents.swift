struct Car {
    enum Manufacturer {
        case porsche, tesla, audi
    }
    
    let numberOfWheels: Int = 4
    let manufacturer: Manufacturer
}


/// map
let cars: [Car] = [Car(manufacturer: .porsche), Car(manufacturer: .tesla), Car(manufacturer: .tesla)]

let manufacturers = cars.map { $0.manufacturer }
print(manufacturers)

/// filter
let posches = cars.filter { $0.manufacturer == .porsche }

/// first
let firstTesla = cars.first(where: { $0.manufacturer == .tesla })

/// reduce
let numberOfWheels = cars.reduce(0) { $0 + $1.numberOfWheels }


let qwer = [1, 2, 3, 4, 5]
let summ = qwer.reduce(0, +)



