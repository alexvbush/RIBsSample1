//
//  ThirdRIBInteractor.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/4/25.
//

import RIBs
import RxSwift

protocol ThirdRIBRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ThirdRIBPresentable: Presentable {
    nonisolated var listener: ThirdRIBPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ThirdRIBListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ThirdRIBInteractor: PresentableInteractor<ThirdRIBPresentable>, ThirdRIBInteractable, ThirdRIBPresentableListener {

    weak var router: ThirdRIBRouting?
    weak var listener: ThirdRIBListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: any ThirdRIBPresentable) {
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
