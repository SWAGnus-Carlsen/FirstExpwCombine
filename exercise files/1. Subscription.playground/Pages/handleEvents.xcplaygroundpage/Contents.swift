//: [Previous](@previous)

// handleEvents
//Performs the specified closures when publisher events occur.
//similar use like print, but can access data and error
//performong side effects without effecting publihser stream

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Post: Codable {
    let id: Int
    let title: String
    let userId: Int
    let body: String
}

let request = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!)
    .map(\.data)
    .decode(type: Post.self, decoder: JSONDecoder())
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("completion: \(completion)")
        case.failure(let error):
            print("Error occured: \(error.localizedDescription)")
        }
    
  }) { data in
    print("received data: \(data)")
  }




//: [Next](@next)
