//
//  RootViewController.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/11/25.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, @MainActor RootPresentable, RootViewControllable {
    
    /*nonisolated(unsafe)*/ weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func embedFirstRIBViewController(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = viewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingConstraint = viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomConstraint = viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraint
        ])
    }
}
