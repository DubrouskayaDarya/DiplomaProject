import UIKit

var greeting = "Hello, playground"


    var i = 0 {
        didSet {
            print("меня поменяли на \(i)")
        }
        
        willSet {
            print("меня хотят поdfменять с \(i) на \(newValue)")
        }
    }



//let a = A()
i = 10
