//
//  RootBuilder.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/11/25.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency>, FirstRIBDependency {

    var firstRIBBuilder: FirstRIBBuildable {
        FirstRIBBuilder(dependency: self)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
//    func build(withListener listener: RootListener) -> RootRouting
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

//    func build(withListener listener: RootListener) -> RootRouting {
//        let component = RootComponent(dependency: dependency)
//        let viewController = RootViewController()
//        let interactor = RootInteractor(presenter: viewController)
//        interactor.listener = listener
//        return RootRouter(interactor: interactor, viewController: viewController)
//    }
    
    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(interactor: interactor, viewController: viewController,
                          firstRIBBuilder: component.firstRIBBuilder)
    }
}
