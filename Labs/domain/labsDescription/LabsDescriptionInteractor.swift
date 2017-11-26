//
//  LabsDescriptionInteractor.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsDescriptionInteractorProtocol {
    var labsDescriptinResponse: Observable<RequestResponse<[Lab]>> { get }
    func makeRequestLabs()
}

class LabsDescriptionInteractor: BaseInteractor {
    var repository: LabsDescriptionRepositoryProtocol! {
        didSet { bind() }
    }
    
    fileprivate var disposeBag: DisposeBag!
    fileprivate let labsDescriptinResponseVariable = Variable<RequestResponse<[Lab]>>(.new)
    
    private func bind() {
        disposeBag = DisposeBag()
        
        repository.labsResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (event) in
                guard let strongSelf = self else { return }

                switch event {
                case .success(let labsAPI):
                    guard let labsAPI = labsAPI else {
                        strongSelf.labsDescriptinResponseVariable.value = .failure(error: "TODO Error")
                        return
                    }

                    guard let labs = Lab.mapArray(labsAPI: labsAPI) else {
                        strongSelf.labsDescriptinResponseVariable.value = .failure(error: "TODO Error")
                        return
                    }

                    strongSelf.labsDescriptinResponseVariable.value = .success(responseObject: labs)
                case .loading:
                    strongSelf.labsDescriptinResponseVariable.value = .loading
                case .failure(let error):
                    strongSelf.labsDescriptinResponseVariable.value = .failure(error: error)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

extension LabsDescriptionInteractor: LabsDescriptionInteractorProtocol {
    
    var labsDescriptinResponse: Observable<RequestResponse<[Lab]>> {
        return labsDescriptinResponseVariable.asObservable()
    }
    
    func makeRequestLabs() {
        repository.getAllLabsInDB()
    }
}
