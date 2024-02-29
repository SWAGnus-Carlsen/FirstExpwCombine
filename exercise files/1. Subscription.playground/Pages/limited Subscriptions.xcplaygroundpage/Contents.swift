//: [Previous](@previous)

// publishers that will pass a limited number of values

import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let foodbank: Publishers.Sequence<[String], Never> = ["apple","bread","orange","milk"].publisher

//let subscription = foodbank.sink { completion in
//    switch completion {
//    case .finished:
//        print("Completion: \(completion) ")
//    case.failure(_):
//        print("Smth went wrong")
//    }
//    
//} receiveValue: { foodItem in
//    print("item: \(foodItem)")
//}

var timer = Timer.publish(every: 1, on: .main, in: .default)
    .autoconnect()

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: Date())!

struct MyError: Error {}

func throwAtEndDate(foodItem: String, date: Date) throws -> String {
    if date < endDate {
        return "\(foodItem) at \(date)"
    } else {
        throw MyError()
    }
}

let subscription = foodbank.zip(timer)
    .tryMap({ (foodItem, timestamp) in 
        return try throwAtEndDate(foodItem: foodItem, date: timestamp)
    })
    .sink { completion in
        switch completion {
        case .finished:
            print("Completion: \(completion) ")
        case.failure(let error):
            print("Smth went wrong: \(error.localizedDescription)")
        }
        
    } receiveValue: { result in
        print(result)
    }




//: [Next](@next)
