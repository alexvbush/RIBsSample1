//
//  RootInteractor.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/11/25.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
}

//protocol FirstRIBPresentable: Presentable where Listener == FirstRIBPresentableListener {
//    func presentStuff()
//}
protocol RootPresentable: Presentable where Listener == RootPresentableListener {
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    nonisolated weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: any RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
