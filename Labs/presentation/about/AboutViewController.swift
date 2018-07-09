//
//  AboutViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 16/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import Spruce

protocol AboutViewProtocol: BaseViewProtocol {
    
}

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var aboutDescriptionTextView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    fileprivate var disposeBag: DisposeBag!
    var presenter: AboutPresenterProtocol!
    
    let sortFunction = LinearSortFunction(direction: .bottomToTop, interObjectDelay: 0.1)
    let spruceAnimations: [StockAnimation] = [.fadeIn, .expand(.slightly)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.aboutTitle()
        addLeftBarButton(image: #imageLiteral(resourceName: "ic_close_white").withRenderingMode(.alwaysTemplate).tint(with: .primaryColor)!) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.presenter.closeButtonTapped()
        }
        
        applyLayout()
        bind()
        
        presenter.viewDidLoad()
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
            .bind(onNext: {[weak self] (description) in
                guard let strongSelf = self else { return }
                strongSelf.aboutDescriptionTextView.text = description
                
                //Create animation in View
                strongSelf.view.spruce.prepare(with: strongSelf.spruceAnimations)
                strongSelf.view.spruce.animate(strongSelf.spruceAnimations, sortFunction: strongSelf.sortFunction)
            })
            .disposed(by: disposeBag)
    }
}

extension AboutViewController: AboutViewProtocol {
    
}
