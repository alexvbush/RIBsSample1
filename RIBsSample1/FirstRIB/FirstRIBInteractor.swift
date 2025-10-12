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

//protocol FirstRIBPresentable: Presentable where Listener == FirstRIBPresentableListener {
//    func presentStuff()
//}
protocol FirstRIBPresentable: Presentable {
    nonisolated var listener: FirstRIBPresentableListener? { get set }

    func presentStuff()
}

protocol FirstRIBListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FirstRIBInteractor: PresentableInteractor<FirstRIBPresentable>, FirstRIBInteractable, FirstRIBPresentableListener {
    
    nonisolated weak var router: FirstRIBRouting?
    nonisolated weak var listener: FirstRIBListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: any FirstRIBPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
//        presenter.listener = Observable.just(1)
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        router?.routeToThirdRIB()
        
        
        Observable.just(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                nonisolated(unsafe) let presenter = self.presenter
                Task { @MainActor in
                    presenter.presentStuff()
                }
                
                self.presentOnMainThread { presenter in
                    presenter.presentStuff()
                }
                
//                presenter.presentStuff()
                
            }).disposeOnDeactivate(interactor: self)
        
//        self.presenter.presentStuff()
    }
    
//    private func executeOnMainThread(closure: @escaping () -> Void) {
//        Task { @MainActor in
//            closure()
//        }
//    }
    
    
    @concurrent
    private func someWork() async {
//        await presenter.presentStuff()
        
//        let presenter = self.presenter
//        nonisolated(unsafe) let presenter = self.presenter
        nonisolated(unsafe) let `self` = self
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
