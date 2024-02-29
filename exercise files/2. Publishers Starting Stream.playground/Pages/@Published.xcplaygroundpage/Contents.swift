//: [Previous](@previous)

/*
 @Published property wrapper
 adds a Publisher to a property

- use `@Published` for class propeties not structures.
 
 */


import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class ViewModel {
    
    // use @Published to create publisher
    @Published private var userNames: [String] = ["Haaland"]
    //let userNames = CurrentValueSubject<[String], Never>(["Bill"])
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        $userNames.sink { [unowned self] value in
            print("received value: \(value) with \(self.userNames)")
        }.store(in: &subscriptions)
        
        newUserNameEntered.sink { [unowned self] value in
            self.userNames.append(value)
        }.store(in: &subscriptions)
    }
}

let viewModel = ViewModel()


// add new user name "Bellingham"
//viewModel.userNames.append("Bellingham")
viewModel.newUserNameEntered.send("Bellingham")

// add new user name "Modric"
viewModel.newUserNameEntered.send("Modric")

//  Documentation: When the property changes, publishing occurs in the property's `willSet` block, meaning subscribers receive the new value before it's actually set on the property.




//: [Next](@next)
