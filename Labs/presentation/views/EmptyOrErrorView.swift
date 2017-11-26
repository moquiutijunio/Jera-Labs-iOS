//
//  EmptyOrErrorView.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import Material

class EmptyOrErrorView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: RaisedButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private var buttonAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        messageLabel.textColor = .primaryColor
        button.titleLabel?.numberOfLines = 0
        
        button.pulseColor = .white
        button.backgroundColor = .primaryColor
        button.setTitleColor(.white, for: .normal)
    }
    
    func showEmpty(text: String, image: UIImage? = nil) {
        messageLabel.text = text
        button.isHidden = true
        imageView.image = image
    }
    
    func showError(text: String, buttonText: String, image: UIImage? = nil, buttonAction: (() -> ())?) {
        self.buttonAction = buttonAction
        messageLabel.text = text
        button.setTitleWithoutAnimation(buttonText, for: .normal)
        imageView.image = image
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        if let buttonAction = buttonAction {
            buttonAction()
        }
    }
}

extension EmptyOrErrorView {
    
    static func build() -> EmptyOrErrorView {
        return R.nib.emptyOrErrorView().instantiate(withOwner: nil, options: nil).first! as! EmptyOrErrorView
    }
}
