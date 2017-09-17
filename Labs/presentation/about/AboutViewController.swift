//
//  AboutViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 16/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol AboutViewProtocol: BaseViewProtocol {
    
}

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var aboutDescriptionTextView: UITextView!
    
    var presenterProtocol: AboutPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.aboutTitle()
        addLeftBarButton(image: #imageLiteral(resourceName: "ic_close_white").withRenderingMode(.alwaysTemplate).tint(with: .primaryColor)!) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.presenterProtocol.closeButtonDidTapped()
        }
        
        applyLayout()
        bind()
    }
    
    private func applyLayout() {
        aboutDescriptionTextView.font = UIFont.boldSystemFont(ofSize: 16)
        aboutDescriptionTextView.isEditable = false
        versionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        versionLabel.textColor = .primaryColor
    }
    
    private func bind() {
        
    }
}

extension AboutViewController: AboutViewProtocol {
    
}
