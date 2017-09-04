//
//  LabInformationPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 01/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabInformationPresenterProtocol {
    
}

class LabInformationPresenter: BasePresenter {
    
    weak var viewProtocol: LabInformationViewProtocol?
    weak var router: LabInformationWireFrameProtocol? {
        didSet {
            bind()
        }
    }
    
    let disposeBag = DisposeBag()
    var labVariable: Variable<Lab>

    init(lab: Lab) {
        labVariable = Variable(lab)
    }
    
    private func bind() {
        labVariable
            .asObservable()
            .subscribe(onNext: { (lab) in
                print("Lab -> \(lab.name)")
            })
            .disposed(by: disposeBag)
    }
}

extension LabInformationPresenter: LabInformationPresenterProtocol {
    
}

