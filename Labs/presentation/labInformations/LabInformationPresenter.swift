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
    var name: Variable<String?> {get}
    var description: Variable<String?> {get}
    var background: Variable<URL?> {get}
    var firtPerson: Variable<URL?> {get}
    var secondPerson : Variable<URL?> {get}
    var thirdPerson: Variable<URL?> {get}
    var fourthPerson: Variable<URL?> {get}
    var fifthPerson: Variable<URL?> {get}
    var appleStore: Variable<Bool> {get}
    var playStore: Variable<Bool> {get}
    var gitlab: Variable<Bool> {get}
    var github: Variable<Bool> {get}
}

class LabInformationPresenter: BasePresenter {
    
    weak var viewProtocol: LabInformationViewProtocol?
    weak var router: LabInformationWireFrameProtocol? {
        didSet {
            bind()
        }
    }
    
    let name = Variable<String?>(nil)
    let description = Variable<String?>(nil)
    let background = Variable<URL?>(nil)
    let firtPerson = Variable<URL?>(nil)
    let secondPerson = Variable<URL?>(nil)
    let thirdPerson = Variable<URL?>(nil)
    let fourthPerson = Variable<URL?>(nil)
    let fifthPerson = Variable<URL?>(nil)
    let appleStore = Variable<Bool>(false)
    let playStore = Variable<Bool>(false)
    let gitlab = Variable<Bool>(false)
    let github = Variable<Bool>(false)
    
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
                strongSelf.firtPerson.value = lab.team?.first
                strongSelf.secondPerson.value = lab.team?.second
                strongSelf.thirdPerson.value = lab.team?.third
                strongSelf.fourthPerson.value = lab.team?.fourth
                strongSelf.fifthPerson.value = lab.team?.fifth
                strongSelf.github.value = lab.github != nil ? true : false
                strongSelf.gitlab.value = lab.gitlab != nil ? true : false
                strongSelf.appleStore.value = lab.appleStore != nil ? true : false
                strongSelf.playStore.value = lab.playStore != nil ? true : false
            })
            .disposed(by: disposeBag)
    }
}

extension LabInformationPresenter: LabInformationPresenterProtocol {
    
}

