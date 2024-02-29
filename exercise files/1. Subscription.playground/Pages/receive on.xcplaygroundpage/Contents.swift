//: [Previous](@previous)

// multithreading
// where and how to change threads?


import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
    .map({ $0 }) // some expensive operation
    .receive(on: DispatchQueue.main)
    .sink(receiveValue: { value in
        print("receive value \(value)")
        print(Thread.current)
    })

intSubject.send(1)

DispatchQueue.global().async {
  intSubject.send(2)
}

//: [Next](@next)
