
protocol NamedCreature {
    var fullName: String { get }
}

struct Person: NamedCreature {
    let firstName: String
    let secondName: String
    
    var fullName: String {
        return firstName + " " + secondName
    }
    
}

struct Pet: NamedCreature {
    let nickName: String
    
    var fullName: String {
        return nickName
    }
    
}


// MARK: - Protocol extensions
extension NamedCreature {
    func call() {
        print("Hey, \(fullName)!")
    }
}

let person = Person(firstName: "Tim", secondName: "Cook")
person.call() /* Prints `Hey, Tim Cook!` */

let cat = Pet(nickName: "Barsik")
cat.call() /* Prints `Hey, Barsik!` */


// we can extend exising types by adopting newly created protocol
extension Int: NamedCreature {
    var fullName: String {
        if abs(self) < 128 {
            return "Small Int"
        } else {
            return "Big Int"
        }
    }
}

100.call() /* Prints `Hey, Small Int!` */

