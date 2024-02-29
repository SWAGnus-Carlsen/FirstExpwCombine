import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//Subject - Publisher that you can continously send new values down

// PassthroughSubject
// use for starting action/process, equivalent to func

let newUserNameEntered = PassthroughSubject<String, Never>()


// get the value for newUserNameEntered
// does not hold a value newUserNameEntered.value

// subscribe to Subject

newUserNameEntered.sink {
    print($0)
} receiveValue: { value in
    print("receive value \(value)")
}

// passing down new values with Subject
newUserNameEntered.send("Haaland")
newUserNameEntered.send("thank god")
// sending completion finished with Subject
    
newUserNameEntered.send(completion: .finished)

newUserNameEntered.send("jjf")


