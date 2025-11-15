//
//  FirstRIBBuilder.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs
import Dispatch

protocol FirstRIBDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

nonisolated final class FirstRIBComponent: Component<FirstRIBDependency>, SecondRIBDependency, ThirdRIBDependency, @unchecked Sendable {
    var secondRIBViewController: any SecondRIBViewControllable {
        viewController
    }
    
    nonisolated var viewController: FirstRIBViewController {
        let viewController = DispatchQueue.main.sync {
            return FirstRIBViewController()
        }
        return viewController
    }

    var secondRIBBuilder: SecondRIBBuildable {
        SecondRIBBuilder(dependency: self)
    }
    
    var thirdRIBBuilder: ThirdRIBBuildable {
        ThirdRIBBuilder(dependency: self)
    }
    
    
    var myService: MyServicable {
        shared { MyService() }
    }
}

// MARK: - Builder

nonisolated protocol FirstRIBBuildable: Buildable {
    func build(withListener listener: FirstRIBListener) -> FirstRIBRouting
}

nonisolated final class FirstRIBBuilder: Builder<FirstRIBDependency>, FirstRIBBuildable {

    override init(dependency: FirstRIBDependency) {
        super.init(dependency: dependency)
    }

    nonisolated func build(withListener listener: FirstRIBListener) -> FirstRIBRouting {
        let component = FirstRIBComponent(dependency: dependency)
        let viewController = component.viewController
        let interactor = FirstRIBInteractor(presenter: viewController, myService: component.myService)
        interactor.listener = listener
        return FirstRIBRouter(interactor: interactor, viewController: viewController, secondRIBBuilder: component.secondRIBBuilder,
                              thirdRIBBuilder: component.thirdRIBBuilder)
    }
}
