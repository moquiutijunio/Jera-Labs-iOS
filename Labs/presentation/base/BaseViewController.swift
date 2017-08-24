//
//  BaseViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol BaseViewProtocol: class {
    func addLogoOnNav()
    func addRightBarButton(image: UIImage, block: @escaping () -> Void )
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        workArroundToBackButton()
    }
    
    private func workArroundToBackButton() {
        let barButtom = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = barButtom
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseViewController: BaseViewProtocol {
    
    func addRightBarButton(image: UIImage, block: @escaping () -> Void ) {
        let rightBarButton = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        _ = rightBarButton.rx.tap
            .subscribe(onNext: { (_) in
                block()
            })
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func addLogoOnNav() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo_jeralabs"))
        self.navigationItem.titleView = imageView
    }
}
