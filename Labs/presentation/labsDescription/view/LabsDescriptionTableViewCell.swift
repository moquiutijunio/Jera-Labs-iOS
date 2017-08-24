//
//  LabsDescriptionTableViewCell.swift
//  Labs
//
//  Created by Junio Moquiuti on 24/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

class LabsDescriptionTableViewModel {
    var labsImage: Variable<UIImage?>
    var labsName: Variable<String?>
    var labsDescription: Variable<String?>
    
    init() { //TODO
        self.labsImage = Variable(#imageLiteral(resourceName: "img_av_parca"))
        self.labsName = Variable("Parça")
        self.labsDescription = Variable("Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça Parça .")
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
        
        labsNameLabel.font = UIFont.systemFont(ofSize: 16)
        labsNameLabel.textColor = UIColor(red:0.2, green:0.77, blue:0.37, alpha:1)
        
        labsDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        labsDescriptionLabel.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:0.87)
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        disposeBag = DisposeBag()
        
        viewModel.labsImage
            .asObservable()
            .bind(to: labsLogoImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.labsName
            .asObservable()
            .bind(to: labsNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.labsDescription
            .asObservable()
            .bind(to: labsDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
