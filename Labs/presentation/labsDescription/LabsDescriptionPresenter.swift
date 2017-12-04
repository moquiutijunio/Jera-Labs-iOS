//
//  LabsDescriptionPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsDescriptionPresenterProtocol {
    var labsDescriptionModel: Variable<[LabsDescriptionTableViewModel]> {get}
    
    func makeRequestLabs()
    func didSelectedRow(at row: Int)
    func aboutIconDidTapped()
}

class LabsDescriptionPresenter: BasePresenter {
    
    weak var viewProtocol: LabsDescriptionViewProtocol?
    weak var router: LabsDescriptionWireFrameProtocol?
    var interactor: LabsDescriptionInteractorProtocol! {
        didSet {bind()}
    }
    
    let disposeBag = DisposeBag()
    var labsDescriptionModel = Variable<[LabsDescriptionTableViewModel]>([])
    
    private func bind() {
        
        interactor.labsDescriptinResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (event) in
                guard let strongSelf = self else { return }
                
                switch event {
                case .success(let labs):
                    strongSelf.buildTableViewSectionsWith(labs)
                    strongSelf.viewProtocol?.hidePlaceholder()
                case .loading:
                    strongSelf.viewProtocol?.placeholder(type: .loading(text: R.string.localizable.alertLoading()), buttonAction: nil)
                case .failure(let error):
                    strongSelf.viewProtocol?.placeholder(type: .error(text: error, buttonText: R.string.localizable.alertTryAgain()), buttonAction: {
                        strongSelf.interactor.makeRequestLabs()
                    })
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func buildTableViewSectionsWith(_ labs: [Lab]) {
        labsDescriptionModel.value.removeAll()
        
        var labsDescription = [LabsDescriptionTableViewModel]()
        
        for lab in labs {
            let viewModel = LabsDescriptionTableViewModel(lab: lab)
            labsDescription.append(viewModel)
        }
        
        labsDescriptionModel.value = labsDescription
        
        viewProtocol?.reloadTableView()
    }
}

extension LabsDescriptionPresenter: LabsDescriptionPresenterProtocol {
    
    func makeRequestLabs() {
        interactor.makeRequestLabs()
    }
    
    func didSelectedRow(at row: Int) {
        router?.openLabInformation(labsDescriptionModel.value[row].lab)
    }
    
    func aboutIconDidTapped() {
        router?.openAboutApp()
    }
}
