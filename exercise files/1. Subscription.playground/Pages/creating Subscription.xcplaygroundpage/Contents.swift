//: [Previous](@previous)

// How to create a subscription?
// What does a publisher without a subscription?
// What does data stream mean?


import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


var sub: AnyCancellable? = Timer.publish(every: 0.5, on: .main, in: .default)
    .autoconnect()
    .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
    .scan(0, { count, _ in
        count + 1
    })
    .filter({$0 < 6})
    
    .sink { completion in
        print("haaland")
    } receiveValue: { timestamp in
        print("Received value: \(timestamp)")
    }


DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    //sub?.cancel()
    sub = nil
}



//: [Next](@next)
