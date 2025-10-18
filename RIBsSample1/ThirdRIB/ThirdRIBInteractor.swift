//
//  ThirdRIBInteractor.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/4/25.
//

import RIBs
import RxSwift
import Dispatch

protocol ThirdRIBRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ThirdRIBPresentable: Presentable {
    nonisolated var listener: ThirdRIBPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

nonisolated protocol ThirdRIBListener: AnyObject {
    func didComplete(_ interactor: ThirdRIBInteractable)
}


actor GlobalStateToTest {
    nonisolated(unsafe) static var subscription: Disposable? = nil
}

final class ThirdRIBInteractor<Presenter: ThirdRIBPresentable>: PresentableInteractor<Presenter>, ThirdRIBInteractable, ThirdRIBPresentableListener, @unchecked Sendable {

    nonisolated(unsafe) weak var router: ThirdRIBRouting?
    nonisolated(unsafe) weak var listener: ThirdRIBListener?
    
    private let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: Presenter) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        Observable.just("Delayed Message")
            .delay(.seconds(3), scheduler: backgroundScheduler)
            .observe(on: backgroundScheduler)
            .subscribe(onNext: { message in
                self.listener?.didComplete(self)
            })
            .disposeOnDeactivate(interactor: self)
        
        GlobalStateToTest.subscription = Observable.just("Delayed Message")
            .delay(.seconds(10), scheduler: backgroundScheduler)
            .observe(on: backgroundScheduler)
            .subscribe(onNext: { message in
                print(self)
            })
            .disposeOnDeactivate(interactor: self)
           
        presentOnMainThread { presenter in
//            sfd
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func close() {
        listener?.didComplete(self)
    }
}
