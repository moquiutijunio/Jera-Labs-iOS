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
    var firtPerson: Variable<URL?> {get}
    var secondPerson : Variable<URL?> {get}
    var thirdPerson: Variable<URL?> {get}
    var fourthPerson: Variable<URL?> {get}
    var fifthPerson: Variable<URL?> {get}
    var appleStore: Variable<URL?> {get}
    var playStore: Variable<URL?> {get}
    var gitlab: Variable<URL?> {get}
    var github: Variable<URL?> {get}
    var background: Variable<URL?> {get}
    var description: Variable<String?> {get}
    var name: Variable<String?> {get}
}

class LabInformationPresenter: BasePresenter {
    
    weak var viewProtocol: LabInformationViewProtocol?
    weak var router: LabInformationWireFrameProtocol? {
        didSet {
            bind()
        }
    }
    
    let firtPerson = Variable<URL?>(nil)
    let secondPerson = Variable<URL?>(nil)
    let thirdPerson = Variable<URL?>(nil)
    let fourthPerson = Variable<URL?>(nil)
    let fifthPerson = Variable<URL?>(nil)
    let appleStore = Variable<URL?>(nil)
    let playStore = Variable<URL?>(nil)
    let gitlab = Variable<URL?>(nil)
    let github = Variable<URL?>(nil)
    let background = Variable<URL?>(nil)
    let description = Variable<String?>(nil)
    let name = Variable<String?>(nil)
    
    let disposeBag = DisposeBag()
    var labVariable: Variable<Lab>

    init(lab: Lab) {
        labVariable = Variable(lab)
    }
    
    private func bind() {
        labVariable
            .asObservable()
            .subscribe(onNext: { [weak self] (lab) in
                guard let strongSelf = self else {return}
                
                strongSelf.name.value = lab.name
                strongSelf.description.value = lab.description
                strongSelf.background.value = lab.background
                strongSelf.github.value = lab.github
                strongSelf.gitlab.value = lab.gitlab
                strongSelf.appleStore.value = lab.appleStore
                strongSelf.playStore.value = lab.playStore
                
                if let firtPersonURL = lab.team?[0] {
                    strongSelf.firtPerson.value = firtPersonURL
                }
                
                if let secondPersonURL = lab.team?[1] {
                    strongSelf.secondPerson.value = secondPersonURL
                }
                
                if let thirdPersonURL = lab.team?[2] {
                    strongSelf.thirdPerson.value = thirdPersonURL
                }
                
                if let fourthPersonURL = lab.team?[3] {
                    strongSelf.fourthPerson.value = fourthPersonURL
                }
                
                if let fifthPersonURL = lab.team?[4] {
                    strongSelf.fifthPerson.value = fifthPersonURL
                }
            })
            .disposed(by: disposeBag)
    }
}

extension LabInformationPresenter: LabInformationPresenterProtocol {
    
}

