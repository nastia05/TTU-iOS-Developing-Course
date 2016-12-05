struct Location {
    let langitude: Double
    let longitude: Double
}

struct University: CustomStringConvertible {
    
    let name: String
    let acronim: String
    let location: Location
    
    var description: String {
        return acronim + " - " + name
    }
}


extension University {
    static var ttu: University {
        let ttuLocation = Location(langitude: 59.394860, longitude: 24.661367)
        return University(name: "Tallinn Technological University", acronim: "TTU", location: ttuLocation)
    }
    
    static var mipt: University {
        let location = Location(langitude: 55.930053, longitude: 37.518253)
        return University(name: "Moscow Institute of Physics and Technology", acronim: "MIPT", location: location)
    }
    
}

// Xcode uses CustomStringConvertible to show information on the right side
let ttu = University.ttu
print(ttu)


//  In order to compare University instances, we must support Equatable protocol
func ==(lhs: University, rhs: University) -> Bool {
    return lhs.name == rhs.name
        && lhs.acronim == rhs.acronim
        && lhs.location.langitude == rhs.location.langitude
        && lhs.location.longitude == rhs.location.longitude
}

extension University: Equatable {
}


University.ttu == University.ttu
University.mipt == University.ttu


//  we should know about Array, Dictionary, Set here


//  In order to use in a set
extension University: Hashable {
    var hashValue: Int {
        return name.hashValue ^ acronim.hashValue ^ location.langitude.hashValue ^ location.longitude.hashValue
    }
}

let universities = Set(arrayLiteral: University.mipt, .ttu)
universities.contains(.mipt)

//  In order to decode and encode University into some entity(of Any type), we must support RawRepresentable protocol
extension University: RawRepresentable {
    // Idealy we should encode and decode to Dictionary type([AnyHashable : Any]) in order to grab any unknown university
    init?(rawValue: String) {
        switch rawValue {
        case "MIPT":
            self = .mipt
        case "TTU":
            self = .ttu
        default:
            return nil
        }
    }
    
    var rawValue: String {
        return acronim
    }
}

//  Little test that encoding and deconding will return the same entity
let originalCopy = University(rawValue: University.mipt.rawValue)

originalCopy == University.mipt






