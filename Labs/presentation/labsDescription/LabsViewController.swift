//
//  LabsViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxCocoa

protocol LabsViewProtocol: BaseViewProtocol {
    
}

class LabsViewController: BaseViewController {
    
    var presenter: LabsPresenterProtocol!
    
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
        
        tableView.register(UINib(nibName: LabsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LabsTableViewCell.nibName())
    }
}

extension LabsViewController: LabsViewProtocol {
    
}

extension LabsViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        return presenter.viewControllerPreviewing(at: indexPath.row)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        presenter.finishViewControllerPreviewing()
    }
    
}

extension LabsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.labsModel.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabsTableViewCell.nibName(), for: indexPath) as! LabsTableViewCell
        cell.viewModel = presenter.labsModel.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectedRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
