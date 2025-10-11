//
//  FirstRIBViewController.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs
import RxSwift
import UIKit

protocol FirstRIBPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class FirstRIBViewController: UIViewController, FirstRIBPresentable, FirstRIBViewControllable {

    nonisolated(unsafe) weak var listener: FirstRIBPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentStuff() {
        
    }
    
    func attachThirRIBViewController(_ viewController: ViewControllable) {
        navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
}
