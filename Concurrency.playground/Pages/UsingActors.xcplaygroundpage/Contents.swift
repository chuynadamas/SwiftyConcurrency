//: [Previous](@previous)

import Foundation

actor Flight {
    let company = "Volare"
    var availableSeats: [String] = ["1A","1B","1C"]
    
    func getAvailableSeats() -> [String] {
        return availableSeats
    }
    
    func bookSeat() -> String {
        let bookedSeat = availableSeats.first ?? ""
        availableSeats.removeFirst()
        return bookedSeat
    }
}

func setUp() {
    let flight: Flight = Flight()
    
    let queue1: DispatchQueue = DispatchQueue(label: "queue1")
    let queue2: DispatchQueue = DispatchQueue(label: "queue2")
    
    queue1.async {
        Task {
            let bookedSeat: String = await flight.bookSeat()
            print("Booked seat is \(bookedSeat)")
        }
    }
    
    queue2.async {
        Task {
            let availableSeat: [String] = await flight.availableSeats
            print("Available seats \(availableSeat)")
        }
    }
}

setUp()


//: [Next](@next)
