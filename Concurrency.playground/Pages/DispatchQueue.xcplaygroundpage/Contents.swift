import Foundation

class Flight {
    let company = "Volare"
    var availableSeats: [String] = ["1A","1B","1C"]
    
    let barrierQueue: DispatchQueue = DispatchQueue(label: "barrier",
                                                    attributes: .concurrent)
    
    func getAvailableSeats() -> [String] {
        barrierQueue.sync(flags: .barrier) {
            return availableSeats
        }
    }
    
    func bookSeat() -> String {
        barrierQueue.sync(flags: .barrier) {
            let bookedSeat = availableSeats.first ?? ""
            availableSeats.removeFirst()
            return bookedSeat
        }
    }
}

func setUp() {
    let flight: Flight = Flight()
    
    let queue1: DispatchQueue = DispatchQueue(label: "queue1", attributes: .concurrent)
    let queue2: DispatchQueue = DispatchQueue(label: "queue2")
    
    queue1.async {
        let bookedSeat: String = flight.bookSeat()
        print("Booked seat is \(bookedSeat)")
    }
    
    queue1.sync {
        let bookedSeat: String = flight.bookSeat()
        print("Booked seat is \(bookedSeat)")
    }
    
    queue2.async {
        let availableSeat: [String] = flight.availableSeats
        print("Available seats \(availableSeat)")
    }
}

setUp()

