//  dummy array, the type can be derived from the context but it was explicitly
var arrayOfDomains: [String] = ["apple.com", "google.com"]

//  for this one we have to add type as it can not be evaluated from context
var arrayOfDifferentThings: [Any] = [1, 2, ""]
    
//  to add something we should do:
arrayOfDomains.append("microsoft.com")

//  to get value at index:
let appleDomain = arrayOfDomains[1]

//  crash when out of range:
//let domainForNotExisingIndex = arrayOfDomains[3]

//  convenience method to get first element:
let firstDomain = arrayOfDomains.first

//  and last one:
let lastDomain = arrayOfDomains.last
    
//  to enumerate through the array
for domain in arrayOfDomains {
    print(domain)
}

//  to get array size(number of elements)
let size = arrayOfDomains.count

//  to remove at index, crashes when out of range:
let element = arrayOfDomains.remove(at: 1)

//  to insert at index, crashes when out of range:
arrayOfDomains.insert("parallels.com", at: 2)

//  to replace at index:
arrayOfDomains[1] = "parallels.com"

//  MARK - do it yourself
struct Student {
    typealias Group = Int
    
    let name: String
    let age: Int
    let group: Group
}

class Classroom {
    private var students: [Student] = []
    
    func add(student: Student) {
        //  TODO: implement insert to the end of the students
    }
    
    func student(with name: String) -> Student? {
        //  iterate through and find first student with specified name
        return nil
    }
    
    func students(of group: Student.Group) -> [Student] {
        //  find all students with specified group
        return []
    }
    
}



