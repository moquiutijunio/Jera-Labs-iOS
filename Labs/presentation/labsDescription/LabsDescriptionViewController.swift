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
        addRightBarButton(image: #imageLiteral(resourceName: "ic_info_outline").withRenderingMode(.alwaysTemplate).tint(with: .gray)!) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.presenterProtocol.aboutIconDidTapped()
        }

        presenterProtocol.makeRequestLabs()
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
        return presenterProtocol.labsDescriptionModel.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabsDescriptionTableViewCell.nibName(), for: indexPath) as! LabsDescriptionTableViewCell
        cell.viewModel = presenterProtocol.labsDescriptionModel.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterProtocol.didSelectedRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
