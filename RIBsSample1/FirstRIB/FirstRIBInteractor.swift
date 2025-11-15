//
//  FirstRIBInteractor.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs
import RxSwift
import Foundation

nonisolated protocol FirstRIBRouting: ViewableRouting {
    var firstRIBViewControllable: FirstRIBViewControllable { get }
    func routeToSecondRIB()
    func routeAwayFromSecondRIB()
    func routeToThirdRIB()
    func routeAwayFromThirdRIB()
}

protocol FirstRIBPresentable: Presentable where Listener == FirstRIBPresentableListener {
    func presentStuff()
}
//protocol FirstRIBPresentable: Presentable {
//    nonisolated var listener: FirstRIBPresentableListener? { get set }
//
//    func presentStuff()
//}

protocol FirstRIBListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FirstRIBInteractor<Presenter: FirstRIBPresentable>: PresentableInteractor<Presenter>, FirstRIBInteractable, FirstRIBPresentableListener, @unchecked Sendable {
    
    nonisolated(unsafe) weak var router: FirstRIBRouting?
    nonisolated(unsafe) weak var listener: FirstRIBListener?
    
    private let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    
    private let myService: MyServicable
    
    init(presenter: Presenter, myService: MyServicable) {
        self.myService = myService
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
//        myService.firstAsyncMethod()
        
        
        
        presentOnMainThread { presenter in
            
        }
        
//        presenter.presentStuff()
        
        Task {
            try await Task.sleep(for: .seconds(2))
            await presenter.presentStuff()
//            presenter.presentStuff()
            
            await test3()
//            test3()
        }
        
        Observable.just(1)
            .subscribe(on: backgroundScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                
//                presenter.presentStuff()
                
            }).disposeOnDeactivate(interactor: self)
        
        
//        nonisolated(unsafe) let presenter = self.presenter
//        Task {
//            try await Task.sleep(for: .seconds(2))
//            
//            Task { @MainActor in
//                presenter.presentStuff()
//            }
////
////            Task { @MainActor in
////               presenter.presentStuff()
////            }
//            
////            self.presentOnMainThread { presenter in
////                presenter.presentStuff()
////            }
//        }
        
//        nonisolated(unsafe) let presenter = self.presenter
//        Task {
//            try await Task.sleep(for: .seconds(2))
//            
//            await MainActor.run {
//                presenter.presentStuff()
//            }
//        }
        
        
        
//        nonisolated(unsafe) let presenter = self.presenter
//        nonisolated(unsafe) let self1 = self
        
        Task {
            try? await Task.sleep(for: .seconds(2))
            
            await MainActor.run {
                presenter.presentStuff()
            }
            
            await presenter.presentStuff()
            
            Task { @MainActor in
                presenter.presentStuff()
            }
            
            self.presentOnMainThread { presenter in
                presenter.presentStuff()
            }
        }
        
//        Task { @MainActor in
//            presenter.presentStuff()
//        }
        
        Observable.just(1)
            .subscribe(on: backgroundScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _  in
                
                self.presentOnMainThread { presenter in
                    presenter.presentStuff()
                }
                
            }).disposeOnDeactivate(interactor: self)
        
        
        router?.routeToThirdRIB()
        
        
    }
    
    
    private func test3() {
        Task { [weak self] in
            guard let self = self else { return }
            self.test1()
        }
    }
    
    private nonisolated func test1() {
        
    }
    
    private func test2() {
//        myService.firstAsyncMethod()
    }
    
    private func test3() async {
        await myService.firstAsyncMethod()
//        myService.secondAsyncMethod()
    }
            
    
//    private func executeOnMainThread(closure: @escaping () -> Void) {
//        Task { @MainActor in
//            closure()
//        }
//    }
    
    
    private func asyncFunction() async {
        
    }
    
    @concurrent
    private func someWork() async {
//        await presenter.presentStuff()
        
//        let presenter = self.presenter
//        nonisolated(unsafe) let presenter = self.presenter
//        nonisolated(unsafe) let `self` = self
        Task { @MainActor in
            // Because this closure is running on the Main Actor,
            // it is now safe to access the presenter and its methods.
//            presenter.presentStuff()
            self.presenter.presentStuff()
        }
        
//        self.presenter.presentStuff()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func doSomeAsyncStuff() async {
        
    }
    
    func didComplete(_ interactor: ThirdRIBInteractable) {
        router?.routeAwayFromThirdRIB()
    }
}
