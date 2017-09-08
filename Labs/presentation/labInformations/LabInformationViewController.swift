//
//  LabInformationViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 01/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture
import UIImageColors

protocol LabInformationViewProtocol: BaseViewProtocol {
    
}

class LabInformationViewController: BaseViewController {
    
    @IBOutlet weak var firstPersonImageView: UIImageView!
    @IBOutlet weak var secondPersonImageView: UIImageView!
    @IBOutlet weak var thirdPersonImageView: UIImageView!
    @IBOutlet weak var fourthPersonImageView: UIImageView!
    @IBOutlet weak var fifthPersonImageView: UIImageView!
    @IBOutlet weak var appleStoreImageView: UIImageView!
    @IBOutlet weak var githubImageView: UIImageView!
    @IBOutlet weak var gitlabImageView: UIImageView!
    @IBOutlet weak var playStoreImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var presenterProtocol: LabInformationPresenterProtocol!
    var mainColors = Variable<UIImageColors?>(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyLayout()
        bind()
    }
    
    private func applyLayout() {
        firstPersonImageView.layer.cornerRadius = firstPersonImageView.frame.size.width/2
        secondPersonImageView.layer.cornerRadius = secondPersonImageView.frame.size.width/2
        thirdPersonImageView.layer.cornerRadius = thirdPersonImageView.frame.size.width/2
        fourthPersonImageView.layer.cornerRadius = fourthPersonImageView.frame.size.width/2
        fifthPersonImageView.layer.cornerRadius = fifthPersonImageView.frame.size.width/2

        firstPersonImageView.clipsToBounds = true
        secondPersonImageView.clipsToBounds = true
        thirdPersonImageView.clipsToBounds = true
        fourthPersonImageView.clipsToBounds = true
        fifthPersonImageView.clipsToBounds = true
        
        appleStoreImageView.image = #imageLiteral(resourceName: "ic_apple").withRenderingMode(.alwaysTemplate)
        githubImageView.image = #imageLiteral(resourceName: "ic_git").withRenderingMode(.alwaysTemplate)
        gitlabImageView.image = #imageLiteral(resourceName: "ic_gitlab").withRenderingMode(.alwaysTemplate)
        playStoreImageView.image = #imageLiteral(resourceName: "ic_playstore").withRenderingMode(.alwaysTemplate)

        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func bind() {
        guard let presenter = presenterProtocol else { return }
        
        mainColors
            .asObservable()
            .subscribe(onNext: { [weak self] (imageColors) in
                guard let strongSelf = self else {return}
                guard let colors = imageColors else {return}
                
                strongSelf.view.backgroundColor = colors.background
                strongSelf.descriptionLabel.textColor = colors.primary
                strongSelf.navigationController?.navigationBar.tintColor = colors.primary
                strongSelf.navigationController?.navigationBar.barTintColor = colors.background
                strongSelf.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colors.primary]
            })
            .disposed(by: disposeBag)
        
        presenter.background
            .asObservable()
            .subscribe(onNext: { [weak self] (image) in
                guard let strongSelf = self else {return}
                guard let image = image else {return}
                strongSelf.backgroundImageView.image = image
                strongSelf.mainColors.value = image.getColors()
            })
            .disposed(by: disposeBag)
        
        presenter.name
            .asObservable()
            .subscribe(onNext: { [weak self] (title) in
                guard let strongSelf = self else {return}
                guard let title = title else {return}
                strongSelf.title = title
            })
            .disposed(by: disposeBag)
        
        presenter.description
            .asObservable()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.firtPerson
            .asObservable()
            .subscribe(onNext: { [weak self] (photoURL) in
                guard let strongSelf = self else { return }
                guard let photoURL = photoURL else { return }
                strongSelf.firstPersonImageView.kf.setImage(with: photoURL)
            })
            .disposed(by: disposeBag)
        
        presenter.secondPerson
            .asObservable()
            .subscribe(onNext: { [weak self] (photoURL) in
                guard let strongSelf = self else { return }
                guard let photoURL = photoURL else { return }
                strongSelf.secondPersonImageView.kf.setImage(with: photoURL)
            })
            .disposed(by: disposeBag)
        
        
        presenter.thirdPerson
            .asObservable()
            .subscribe(onNext: { [weak self] (photoURL) in
                guard let strongSelf = self else { return }
                guard let photoURL = photoURL else { return }
                strongSelf.thirdPersonImageView.kf.setImage(with: photoURL)
            })
            .disposed(by: disposeBag)
        
        presenter.fourthPerson
            .asObservable()
            .subscribe(onNext: { [weak self] (photoURL) in
                guard let strongSelf = self else { return }
                guard let photoURL = photoURL else { return }
                strongSelf.fourthPersonImageView.kf.setImage(with: photoURL)
            })
            .disposed(by: disposeBag)
        
        presenter.fifthPerson
            .asObservable()
            .subscribe(onNext: { [weak self] (photoURL) in
                guard let strongSelf = self else { return }
                guard let photoURL = photoURL else { return }
                strongSelf.fifthPersonImageView.kf.setImage(with: photoURL)
            })
            .disposed(by: disposeBag)
        
        presenter.gitlabState
            .asObservable()
            .subscribe(onNext: { [weak self] (state) in
                guard let strongSelf = self else {return}
                strongSelf.gitlabImageView.tintColor = state == true ? .black : .gray
            })
            .disposed(by: disposeBag)
        
        presenter.githubState
            .asObservable()
            .subscribe(onNext: { [weak self] (state) in
                guard let strongSelf = self else {return}
                strongSelf.githubImageView.tintColor = state == true ? .black : .gray
            })
            .disposed(by: disposeBag)
        
        presenter.playStoreState
            .asObservable()
            .subscribe(onNext: { [weak self] (state) in
                guard let strongSelf = self else {return}
                strongSelf.playStoreImageView.tintColor = state == true ? .black : .gray
            })
            .disposed(by: disposeBag)
        
        presenter.appleStoreState
            .asObservable()
            .subscribe(onNext: { [weak self] (state) in
                guard let strongSelf = self else {return}
                strongSelf.appleStoreImageView.tintColor = state == true ? .black : .gray
            })
            .disposed(by: disposeBag)
        
        appleStoreImageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] (_) in
                guard let strongSelf = self else {return}
                strongSelf.presenterProtocol.appleStoreDidTap()
            })
            .disposed(by: disposeBag)
        
        playStoreImageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] (_) in
                guard let strongSelf = self else {return}
                strongSelf.presenterProtocol.playStoreDidTap()
            })
            .disposed(by: disposeBag)
        
        githubImageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] (_) in
                guard let strongSelf = self else {return}
                strongSelf.presenterProtocol.githubDidTap()
            })
            .disposed(by: disposeBag)
        
        gitlabImageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] (_) in
                guard let strongSelf = self else {return}
                strongSelf.presenterProtocol.gitlabDidTap()
            })
            .disposed(by: disposeBag)
    }
}

extension LabInformationViewController: LabInformationViewProtocol {
    
}
