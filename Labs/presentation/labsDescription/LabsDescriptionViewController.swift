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
    
    var presenterProtocol: LabsDescriptionPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        addLogoOnNav()
        addRightBarButton(image: #imageLiteral(resourceName: "ic_info_outline").withRenderingMode(.alwaysTemplate)) {
            print("TODO Show about view")
        }
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

extension LabsDescriptionViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabsDescriptionTableViewCell.nibName()) as? LabsDescriptionTableViewCell
        if let cell = cell {
            let viewModel = LabsDescriptionTableViewModel()
            cell.viewModel = viewModel
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        default:
            break
        }
    }
}
