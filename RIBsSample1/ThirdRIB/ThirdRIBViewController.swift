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
    func close()
}

final class ThirdRIBViewController: UIViewController, ThirdRIBPresentable, ThirdRIBViewControllable {

    nonisolated(unsafe) weak var listener: ThirdRIBPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let isNavbarBeingDismissed = navigationController?.isBeingDismissed ?? false
        if isMovingFromParent || isBeingDismissed || isNavbarBeingDismissed {
            listener?.close()
        }
    }
}
