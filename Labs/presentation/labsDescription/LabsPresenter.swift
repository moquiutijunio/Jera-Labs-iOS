//
//  LabsPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsPresenterProtocol {
    var labsModel: Variable<[LabsTableViewModel]> {get}
    
    func viewDidLoad()
    func didSelectedRow(at row: Int)
    func viewControllerPreviewing(at row: Int) -> UIViewController?
    func finishViewControllerPreviewing()
    func aboutButtonTapped()
}

class LabsPresenter: BasePresenter {
    
    weak var viewProtocol: LabsViewProtocol?
    weak var router: LabsWireFrameProtocol?
    var interactor: LabsInteractorProtocol
    
    let disposeBag = DisposeBag()
    var labsModel = Variable<[LabsTableViewModel]>([])
    
    init(interactor: LabsInteractorProtocol) {
        self.interactor = interactor
        super.init()
        bind()
    }
    
    private func bind() {
        
        interactor.labsRequestResponse
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
        labsModel.value.removeAll()
        
        var labsViewModel = [LabsTableViewModel]()
        
        for lab in labs {
            let viewModel = LabsTableViewModel(lab: lab)
            labsViewModel.append(viewModel)
        }
        
        labsModel.value = labsViewModel
        
        viewProtocol?.reloadTableView()
    }
}

extension LabsPresenter: LabsPresenterProtocol {
    
    func viewDidLoad() {
        interactor.makeRequestLabs()
    }
    
    func didSelectedRow(at row: Int) {
        router?.showLabInformation(with: labsModel.value[row].lab)
    }
    
    func viewControllerPreviewing(at row: Int) -> UIViewController? {
        return router?.showPreviewLabInformationFor(lab: labsModel.value[row].lab)
    }
    
    func finishViewControllerPreviewing() {
        router?.finishPreviewingLabInformation()
    }
    
    func aboutButtonTapped() {
        router?.showAbout()
    }
}
