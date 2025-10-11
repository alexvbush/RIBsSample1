//
//  ThirdRIBBuilder.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/4/25.
//

import RIBs

protocol ThirdRIBDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

nonisolated final class ThirdRIBComponent: Component<ThirdRIBDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ThirdRIBBuildable: Buildable {
    func build(withListener listener: ThirdRIBListener) -> ThirdRIBRouting
}

nonisolated final class ThirdRIBBuilder: Builder<ThirdRIBDependency>, ThirdRIBBuildable {

    override init(dependency: ThirdRIBDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ThirdRIBListener) -> ThirdRIBRouting {
        _ = ThirdRIBComponent(dependency: dependency)
        let viewController = ThirdRIBViewController()
        let interactor = ThirdRIBInteractor(presenter: viewController)
        interactor.listener = listener
        return ThirdRIBRouter(interactor: interactor, viewController: viewController)
    }
}
