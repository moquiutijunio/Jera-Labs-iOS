//
//  AboutPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 16/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol AboutPresenterProtocol: BasePresenterProtocol {
    var version: Variable<String> {get}
    var description: Variable<String> {get}
    
    func closeButtonDidTapped()
}

class AboutPresenter: BasePresenter {
    
    weak var viewProtocol: AboutViewProtocol?
    weak var router: AboutWireFrameProtocol?
    
    let version = Variable<String>(R.string.localizable.aboutVersion())
    let description = Variable<String>(R.string.localizable.aboutDescription())
    
}

extension AboutPresenter: AboutPresenterProtocol {
    func closeButtonDidTapped() {
        router?.dismiss()
    }
}
