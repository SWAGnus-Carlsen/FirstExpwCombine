//: [Previous](@previous)

//Example for CurrentValueSubject and PassthroughSubject
//PassthroughSubject: use for starting action/process, equivalent to func


import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class ViewModel {
    
    let userNamesSubject = CurrentValueSubject<[String], Never>(["Bill"])
    var userNames: AnyPublisher<[String], Never>
    
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        userNames = userNamesSubject.eraseToAnyPublisher()
        newUserNameEntered
            .filter({$0.count > 3})
            .sink { [unowned self] newUserName in
                // self.userNamesSubject.send(self.userNamesSubject.value + [newUserName])
                // self.userNamesSubject.value += [newUserName]
                // self.userNamesSubject.value.append(newUserName)
                self.userNamesSubject.value.append(contentsOf: [newUserName])
            }.store(in: &subscriptions)
        
        
        //it's just simply better than didSet on userNames property
        userNames.sink {
            print("current usernames array: \($0)")
        }.store(in: &subscriptions)
    }
}

let viewModel = ViewModel()

// add new user name "Haaland"
viewModel.newUserNameEntered.send("Haaland")
// add new user name "Gvardiol"
viewModel.newUserNameEntered.send("Gvardiol")

// who do you protect userName from not setting it directly

// it's bad when we have an access directly to the property that stores all our names, so because of that we have to provide some way how to limit the access to this proprty
//viewModel.userNames.send(["Baaaaaaalllliiiiing like my nigga Mo"])




//: [Next](@next)
