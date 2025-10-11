//
//  FirstRIBBuilder.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs

protocol FirstRIBDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

nonisolated final class FirstRIBComponent: Component<FirstRIBDependency>, SecondRIBDependency, ThirdRIBDependency {
    var secondRIBViewController: any SecondRIBViewControllable {
        viewController
    }
    
    var viewController: FirstRIBViewController {
        FirstRIBViewController()
    }

    var secondRIBBuilder: SecondRIBBuildable {
        SecondRIBBuilder(dependency: self)
    }
    
    var thirdRIBBuilder: ThirdRIBBuildable {
        ThirdRIBBuilder(dependency: self)
    }
}

// MARK: - Builder

protocol FirstRIBBuildable: Buildable {
    func build(withListener listener: FirstRIBListener) -> FirstRIBRouting
}

nonisolated final class FirstRIBBuilder: Builder<FirstRIBDependency>, FirstRIBBuildable {

    override init(dependency: FirstRIBDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FirstRIBListener) -> FirstRIBRouting {
        let component = FirstRIBComponent(dependency: dependency)
        let viewController = component.viewController
        let interactor = FirstRIBInteractor(presenter: viewController)
        interactor.listener = listener
        return FirstRIBRouter(interactor: interactor, viewController: viewController, secondRIBBuilder: component.secondRIBBuilder,
                              thirdRIBBuilder: component.thirdRIBBuilder)
    }
}
