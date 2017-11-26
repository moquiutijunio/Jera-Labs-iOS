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
    
    func makeRequestAbout()
    func closeButtonDidTapped()
}

class AboutPresenter: BasePresenter {
    
    weak var viewProtocol: AboutViewProtocol?
    weak var router: AboutWireFrameProtocol?
    var interactor: AboutInteractorProtocol! {
        didSet {bind()}
    }
    
    var disposeBag: DisposeBag!
    let version = Variable<String>("")
    let description = Variable<String>("")

    private func bind() {
        disposeBag = DisposeBag()
        
        interactor.aboutResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (event) in
                guard let strongSelf = self else { return }
                
                switch event {
                case .success(let about):
                    strongSelf.version.value = about.version
                    strongSelf.description.value = about.description
                    
                    strongSelf.viewProtocol?.hidePlaceholder()
                case .loading:
                    strongSelf.viewProtocol?.placeholder(type: .loading(text: R.string.localizable.alertLoading()), buttonAction: nil)
                case .failure(let error):
                    strongSelf.viewProtocol?.placeholder(type: .error(text: error, buttonText: R.string.localizable.alertTryAgain()), buttonAction: {
                        strongSelf.interactor.makeRequestAbout()
                    })
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

extension AboutPresenter: AboutPresenterProtocol {
    
    func makeRequestAbout() {
        interactor.makeRequestAbout()
    }
    
    func closeButtonDidTapped() {
        router?.dismiss()
    }
}
