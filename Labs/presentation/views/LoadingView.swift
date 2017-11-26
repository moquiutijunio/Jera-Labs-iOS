//
//  LoadingView.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .primaryColor
        messageLabel.textColor = .primaryColor
    }
    
    func populate(text: String) {
        messageLabel.text = text
        activityIndicatorView.startAnimating()
    }
}

extension LoadingView {
    
    static func build() -> LoadingView {
        return R.nib.loadingView().instantiate(withOwner: nil, options: nil).first! as! LoadingView
    }
}
