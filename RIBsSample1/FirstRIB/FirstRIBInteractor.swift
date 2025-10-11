//
//  FirstRIBInteractor.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs
import RxSwift

nonisolated protocol FirstRIBRouting: ViewableRouting {
    func routeToSecondRIB()
    func routeAwayFromSecondRIB()
    func routeToThirdRIB()
    func routeAwayFromThirdRIB()
}

//protocol FirstRIBPresentable: Presentable where Listener == FirstRIBPresentableListener {
protocol FirstRIBPresentable: Presentable {
//    var listener: FirstRIBPresentableListener? { get set }
    nonisolated var listener: FirstRIBPresentableListener? { get set }

    func presentStuff()
}

protocol FirstRIBListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FirstRIBInteractor: PresentableInteractor<FirstRIBPresentable>, FirstRIBInteractable, FirstRIBPresentableListener {
    
    nonisolated weak var router: FirstRIBRouting?
    weak var listener: FirstRIBListener?
    
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
                
//                Task { @MainActor [weak self] in
//                    guard let self else { return }
//                        await MainActor.run { [weak self] in
//                            guard let self else { return }
//                            self.presenter.presentStuff()
//                        }
//                    }
                
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    self.presenter.presentStuff()
                }
                
                
                
            }).disposeOnDeactivate(interactor: self)
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func doSomeAsyncStuff() async {
        
    }
}
