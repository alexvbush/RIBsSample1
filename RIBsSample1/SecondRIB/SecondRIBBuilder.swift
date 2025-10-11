//
//  SecondRIBBuilder.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs

protocol SecondRIBDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var SecondRIBViewController: SecondRIBViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

nonisolated final class SecondRIBComponent: Component<SecondRIBDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var SecondRIBViewController: SecondRIBViewControllable {
        return dependency.SecondRIBViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SecondRIBBuildable: Buildable {
    func build(withListener listener: SecondRIBListener) -> SecondRIBRouting
}

final class SecondRIBBuilder: Builder<SecondRIBDependency>, SecondRIBBuildable {

    nonisolated override init(dependency: SecondRIBDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SecondRIBListener) -> SecondRIBRouting {
        let component = SecondRIBComponent(dependency: dependency)
        let interactor = SecondRIBInteractor()
        interactor.listener = listener
        return SecondRIBRouter(interactor: interactor, viewController: component.SecondRIBViewController)
    }
}
