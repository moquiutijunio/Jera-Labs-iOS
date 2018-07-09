//
//  AboutInteractor.swift
//  Labs
//
//  Created by Junio Moquiuti on 20/11/2017.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol AboutInteractorProtocol {
    var aboutResponse: Observable<RequestResponse<About>> { get }
    func makeRequestAbout()
}

class AboutInteractor: BaseInteractor {
    
    var repository: AboutRepositoryProtocol
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate let aboutResponseVariable = Variable<RequestResponse<About>>(.new)
    
    init(repository: AboutRepositoryProtocol) {
        self.repository = repository
        super.init()
        bind()
    }
    
    private func bind() {
        
        repository.aboutResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (event) in
                guard let strongSelf = self else { return }
                
                switch event {
                case .success(let aboutAPI):
                    guard let aboutAPI = aboutAPI else {
                        strongSelf.aboutResponseVariable.value = .failure(error: "TODO Error")
                        return
                    }
                    
                    guard let about = About.map(aboutAPI: aboutAPI) else {
                        strongSelf.aboutResponseVariable.value = .failure(error: "TODO Error")
                        return
                    }
                    
                    strongSelf.aboutResponseVariable.value = .success(responseObject: about)
                case .loading:
                    strongSelf.aboutResponseVariable.value = .loading
                case .failure(let error):
                    strongSelf.aboutResponseVariable.value = .failure(error: error)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

extension AboutInteractor: AboutInteractorProtocol {
    
    var aboutResponse: Observable<RequestResponse<About>> {
        return aboutResponseVariable.asObservable()
    }
    
    func makeRequestAbout() {
        repository.getAboutInformationInDB()
    }
}
