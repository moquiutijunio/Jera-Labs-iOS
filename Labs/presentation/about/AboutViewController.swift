//
//  AboutViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 16/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol AboutViewProtocol: BaseViewProtocol {
    
}

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var aboutDescriptionTextView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    fileprivate var disposeBag: DisposeBag!
    var presenter: AboutPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.aboutTitle()
        addLeftBarButton(image: #imageLiteral(resourceName: "ic_close_white").withRenderingMode(.alwaysTemplate).tint(with: .primaryColor)!) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.presenter.closeButtonDidTapped()
        }
        
        applyLayout()
        bind()
    }
    
    private func applyLayout() {
        iconImageView.image = #imageLiteral(resourceName: "logo_jera")
        versionLabel.font = R.font.montserratSemiBold(size: 16)
        versionLabel.textColor = .primaryColor
        aboutDescriptionTextView.font = R.font.montserratRegular(size: 14)
        aboutDescriptionTextView.textColor = .black
        aboutDescriptionTextView.isEditable = false
    }
    
    private func bind() {
        disposeBag = DisposeBag()
        
        presenter.version
            .asObservable()
            .bind(to: versionLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.description
            .asObservable()
            .bind(to: aboutDescriptionTextView.rx.text)
            .disposed(by: disposeBag)
    }
}

extension AboutViewController: AboutViewProtocol {
    
}
