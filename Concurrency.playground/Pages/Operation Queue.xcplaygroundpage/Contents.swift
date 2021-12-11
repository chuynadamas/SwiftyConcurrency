//: [Previous](@previous)

import Foundation

class CustomOperation: Operation {
    
    var emoji: String = ""
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        self.executing(true)
        
        //Asynchronous logic (eg: n/w calls) with callback
        for _ in 0..<1000 {
            if !isCancelled {
                print(emoji)
            } else {
                print("🧨 The operation was canceled")
                break
            }
        }
    }
    
    required init(emoji: String) {
        self.emoji = emoji
    }
}

var customOperationQueue : OperationQueue = OperationQueue()
customOperationQueue.name = "someCustomOperationQueue"
customOperationQueue.qualityOfService = .userInteractive
customOperationQueue.maxConcurrentOperationCount = 10

var operation1 = CustomOperation(emoji: "🍄")
var operation2 = CustomOperation(emoji: "🚀")

operation1.completionBlock = {
    print("Finished the work operation 1")
}

operation2.completionBlock = {
    print("Finished the work operaion 2")
}

customOperationQueue.addOperation(operation1)
customOperationQueue.addOperation(operation2)

DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
    operation2.cancel()
}


//: [Next](@next)
