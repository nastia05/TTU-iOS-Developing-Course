//MARK: - Tree
struct Node {
    var value: Int
    var children: [Node] = []
    
    init(value: Int) {
        self.value = value
    }
    
    mutating func addNode(with value: Int) {
        children.append(Node(value: value))
    }
    
    //convenient initialisers to create a dummy tree
    init(value: Int, childValues: Int...) {
        self.value = value
        self.children = childValues.map({ Node(value: $0)})
    }
    
    init(value: Int, childNodes: Node...) {
        self.value = value
        self.children = childNodes
    }
    
}

// MARK: - inside of this extension write two functions
extension Node {
    
    /*1. Write a function that goes through the tree and returns the first element which satisfies the condition. If no element found, return nil;
        condition is expressed by closure (Int) -> Bool
     */
    
    
    /*2. Write a filter function that goes through the tree and returns an array of all elements which satisfy the condition. If no element found, return empty array;
        condition is expressed by closure (Int) -> Bool
     */

}


//MARK: - test your code
//To test the code, we create a very dummy tree and apply some rules to it.

let middle1 = Node(value: 5, childValues: 13, 16)
let middle2 = Node(value: 7, childValues: 24)
let tree = Node(value: 1, childNodes: middle1, middle2)

//Use the tree to find first object and filter objects that satisfy the conditions:
// element is > 12, > 0, > 50, == 4, == 13, < 15.
