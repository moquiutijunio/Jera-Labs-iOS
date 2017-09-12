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
    var backgroundURL: Variable<URL?> {get}
    var firtPerson: Variable<URL?> {get}
    var secondPerson : Variable<URL?> {get}
    var thirdPerson: Variable<URL?> {get}
    var fourthPerson: Variable<URL?> {get}
    var fifthPerson: Variable<URL?> {get}
    var appleStoreState: Variable<Bool> {get}
    var playStoreState: Variable<Bool> {get}
    var gitlabState: Variable<Bool> {get}
    var githubState: Variable<Bool> {get}
    
    func appleStoreDidTap()
    func playStoreDidTap()
    func githubDidTap()
    func gitlabDidTap()
}

class LabInformationPresenter: BasePresenter {
    
    weak var viewProtocol: LabInformationViewProtocol?
    weak var router: LabInformationWireFrameProtocol?
    
    let name = Variable<String?>(nil)
    let description = Variable<String?>(nil)
    let firtPerson = Variable<URL?>(nil)
    let secondPerson = Variable<URL?>(nil)
    let thirdPerson = Variable<URL?>(nil)
    let fourthPerson = Variable<URL?>(nil)
    let fifthPerson = Variable<URL?>(nil)
    let appleStoreState = Variable<Bool>(false)
    let playStoreState = Variable<Bool>(false)
    let gitlabState = Variable<Bool>(false)
    let githubState = Variable<Bool>(false)
    let backgroundURL = Variable<URL?>(nil)
    
    let disposeBag = DisposeBag()
    var labVariable: Variable<Lab>

    init(lab: Lab) {
        labVariable = Variable(lab)
        super.init()
        bind()
    }
    
    private func bind() {
        labVariable
            .asObservable()
            .subscribe(onNext: { [weak self] (lab) in
                guard let strongSelf = self else {return}
                
                strongSelf.name.value = lab.name
                strongSelf.description.value = lab.description
                strongSelf.backgroundURL.value = lab.background
                strongSelf.firtPerson.value = lab.team?.first
                strongSelf.secondPerson.value = lab.team?.second
                strongSelf.thirdPerson.value = lab.team?.third
                strongSelf.fourthPerson.value = lab.team?.fourth
                strongSelf.fifthPerson.value = lab.team?.fifth
                strongSelf.githubState.value = lab.github != nil ? true : false
                strongSelf.gitlabState.value = lab.gitlab != nil ? true : false
                strongSelf.appleStoreState.value = lab.appleStore != nil ? true : false
                strongSelf.playStoreState.value = lab.playStore != nil ? true : false
            })
            .disposed(by: disposeBag)
    }
}

extension LabInformationPresenter: LabInformationPresenterProtocol {
    func appleStoreDidTap() {
        if appleStoreState.value,
            let appleStoreURL = labVariable.value.appleStore {
            router?.openWebViewWith(url: appleStoreURL, title: labVariable.value.name)
        }
    }
    
    func playStoreDidTap() {
        if playStoreState.value,
            let playStoreURL = labVariable.value.playStore {
            router?.openWebViewWith(url: playStoreURL, title: labVariable.value.name)
        }
    }
    
    func githubDidTap() {
        if githubState.value,
            let githubURL = labVariable.value.github {
            router?.openWebViewWith(url: githubURL, title: labVariable.value.name)
        }
    }
    
    func gitlabDidTap() {
        if gitlabState.value,
            let gitlabURL = labVariable.value.gitlab {
            router?.openWebViewWith(url: gitlabURL, title: labVariable.value.name)
        }
    }
}

