//
//  AboutPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 16/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol AboutPresenterProtocol: BasePresenterProtocol {
    func closeButtonDidTapped()
}

class AboutPresenter: BasePresenter {
    
    weak var viewProtocol: AboutViewProtocol?
    weak var router: AboutWireFrameProtocol?
    
}

extension AboutPresenter: AboutPresenterProtocol {
    func closeButtonDidTapped() {
        router?.dismiss()
    }
}
