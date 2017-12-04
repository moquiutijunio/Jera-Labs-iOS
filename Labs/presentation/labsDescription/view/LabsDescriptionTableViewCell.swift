//
//  LabsDescriptionTableViewCell.swift
//  Labs
//
//  Created by Junio Moquiuti on 24/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class LabsDescriptionTableViewModel {
    var lab: Lab
    var labAvatar: Variable<URL?>
    var labName: Variable<String?>
    var labDescription: Variable<String?>
    
    init(lab: Lab) {
        self.lab = lab
        self.labAvatar = Variable(lab.avatar)
        self.labName = Variable(lab.name)
        self.labDescription = Variable(lab.description)
    }
}

class LabsDescriptionTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var labsLogoImageView: UIImageView!
    
    @IBOutlet weak var labsNameLabel: UILabel!
    @IBOutlet weak var labsDescriptionLabel: UILabel!
    
    fileprivate var disposeBag: DisposeBag!
    var viewModel: LabsDescriptionTableViewModel? {
        didSet {bind()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        selectedColor = .clear
        
        labsLogoImageView.layer.cornerRadius = labsLogoImageView.frame.height/2
        labsLogoImageView.clipsToBounds = true
        
        labsNameLabel.font = UIFont.systemFont(ofSize: 16)
        labsNameLabel.textColor = UIColor(red: 0.2, green: 0.77, blue: 0.37, alpha: 1)
        
        labsDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        labsDescriptionLabel.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 0.87)
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        disposeBag = DisposeBag()
        
        viewModel.labAvatar
            .asObservable()
            .subscribe(onNext: { [weak self] (avatarURL) in
                guard let strongSelf = self else { return }
                guard let avatarURL = avatarURL else { return }
                
                strongSelf.labsLogoImageView.kf.setImage(with: avatarURL)
            })
            .disposed(by: disposeBag)
        
        viewModel.labName
            .asObservable()
            .bind(to: labsNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.labDescription
            .asObservable()
            .bind(to: labsDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
