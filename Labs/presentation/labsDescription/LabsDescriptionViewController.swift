//
//  LabsDescriptionViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxCocoa

protocol LabsDescriptionViewProtocol: BaseViewProtocol {
    
}

class LabsDescriptionViewController: BaseViewController {
    
    var presenter: LabsDescriptionPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        addLogoOnNav()
        addRightBarButton(image: #imageLiteral(resourceName: "ic_info_outline").withRenderingMode(.alwaysTemplate).tint(with: .gray)!) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.presenter.aboutIconDidTapped()
        }
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }

        presenter.makeRequestLabs()
    }
    
    override func configureTableView() {
        super.configureTableView()
        
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 71
        
        tableView.register(UINib(nibName: LabsDescriptionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LabsDescriptionTableViewCell.nibName())
    }
}

extension LabsDescriptionViewController: LabsDescriptionViewProtocol {
    
}

extension LabsDescriptionViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        return presenter.viewControllerPreviewing(at: indexPath.row)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        presenter.finishViewControllerPreviewing()
    }
    
}

extension LabsDescriptionViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.labsDescriptionModel.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabsDescriptionTableViewCell.nibName(), for: indexPath) as! LabsDescriptionTableViewCell
        cell.viewModel = presenter.labsDescriptionModel.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectedRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
