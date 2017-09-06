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
    func makeRequestLabs()
    func numberOfRows(section: Int) -> Int
    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectedRow(at indexPath: IndexPath)
}

class LabsDescriptionPresenter: BasePresenter {
    
    weak var viewProtocol: LabsDescriptionViewProtocol?
    weak var router: LabsDescriptionWireFrameProtocol?
    var interactor: LabsDescriptionInteractorProtocol! {
        didSet {
            bind()
        }
    }
    
    let disposeBag = DisposeBag()
    var labsDescriptionTableViewModel = [LabsDescriptionTableViewModel]()
    var currentLabs = [Lab]()
    
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
        currentLabs.removeAll()
        labsDescriptionTableViewModel.removeAll()
        
        for lab in labs {
            currentLabs.append(lab)
            let viewModel = LabsDescriptionTableViewModel(lab: lab)
            labsDescriptionTableViewModel.append(viewModel)
        }
        
        viewProtocol?.reloadTableView()
    }
}

extension LabsDescriptionPresenter: LabsDescriptionPresenterProtocol {
    
    func makeRequestLabs() {
        interactor.makeRequestLabs()
    }
    
    func numberOfRows(section: Int) -> Int {
        return labsDescriptionTableViewModel.count
    }
    
    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabsDescriptionTableViewCell.nibName(), for: indexPath) as! LabsDescriptionTableViewCell
        cell.viewModel = labsDescriptionTableViewModel[indexPath.row]
        return cell
    }

    func didSelectedRow(at indexPath: IndexPath) {
        router?.openLabInformation(currentLabs[indexPath.row])
    }
}
