protocol Animal {
    associatedtype FoodType
    
    mutating func eat(food: FoodType)
}

struct Grass {
}

struct Cow: Animal {
    func eat(food: Grass) {
        
    }
}

struct Tiger: Animal {
    func eat(food: Cow) {
        
    }
}
