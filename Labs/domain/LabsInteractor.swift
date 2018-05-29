//
//  LabsInteractor.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsInteractorProtocol {
    var labsRequestResponse: Observable<RequestResponse<[Lab]>> { get }
    func makeRequestLabs()
}

class LabsInteractor: BaseInteractor {
    var repository: LabsRepositoryProtocol! {
        didSet { bind() }
    }
    
    fileprivate var disposeBag: DisposeBag!
    fileprivate let labsResponseVariable = Variable<RequestResponse<[Lab]>>(.new)
    
    private func bind() {
        disposeBag = DisposeBag()
        
        repository.labsResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (event) in
                guard let strongSelf = self else { return }

                switch event {
                case .success(let labsAPI):
                    guard let labsAPI = labsAPI, let labs = Lab.mapArray(labsAPI: labsAPI) else {
                        strongSelf.labsResponseVariable.value = .failure(error: R.string.localizable.messageError())
                        return
                    }

                    strongSelf.labsResponseVariable.value = .success(responseObject: labs)
                    
                case .loading:
                    strongSelf.labsResponseVariable.value = .loading
                    
                case .failure(let error):
                    strongSelf.labsResponseVariable.value = .failure(error: error)
                    
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

extension LabsInteractor: LabsInteractorProtocol {
    
    var labsRequestResponse: Observable<RequestResponse<[Lab]>> {
        return labsResponseVariable.asObservable()
    }
    
    func makeRequestLabs() {
        repository.getAllLabsInDB()
    }
}
