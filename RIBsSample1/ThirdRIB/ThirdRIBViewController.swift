//
//  ThirdRIBViewController.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/4/25.
//

import RIBs
import RxSwift
import UIKit

protocol ThirdRIBPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ThirdRIBViewController: UIViewController, ThirdRIBPresentable, ThirdRIBViewControllable {

    nonisolated(unsafe) weak var listener: ThirdRIBPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
