//: [Previous](@previous)

//Subject - Publisher that you can continously send new values down

//CurrentValueSubject
//used like a var with a Publisher stream attached

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct User {
    var id: Int
    var name: String
}

let currentUserId = CurrentValueSubject<Int     , Never>(1000)
let userNames     = CurrentValueSubject<[String], Never>(["Bob", "Susan", "Luise"])

//let currentUser   = CurrentValueSubject<User    , Never>(User(id: 1, name: "Bob"))



// get the value for currentUserID
print("CurrentUserId: \(currentUserId.value)")
// subscribe to Subject

//Somehow it does work even without storing it in variable
let sub = currentUserId.sink {
    print("Completion: \($0)")
} receiveValue: { value in
    print("Received value: \(value)")
}

// passing down new values with Subject
currentUserId.send(1)
currentUserId.send(2)
// sending completion finished with Subject

currentUserId.send(completion: .finished)

currentUserId.send(3) // we've finished the datastream by passing completion few lines above

//: [Next](@next)
