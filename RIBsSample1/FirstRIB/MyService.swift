//
//  MyService.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/18/25.
//

protocol MyServicable: Actor {
    func firstAsyncMethod() async
    func secondAsyncMethod() async
}

actor MyService: MyServicable {
    
//    init () {
//        
//    }
    
    func firstAsyncMethod() async {
        print("firstAsyncMethod called")
    }
    
    func secondAsyncMethod() async {
        print("secondAsyncMethod called")
    }
}

//final class MyService: MyServicable {
//    
//    @MainActor
//    init() {
//        
//    }
//    
//    func firstAsyncMethod() async {
//        
//    }
//    
//    func secondAsyncMethod() async {
//        
//    }
//}
