//
//  PlaceholderView.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import Cartography

enum PlaceholderType {
    case error(text: String, buttonText: String)
    case loading(text: String)
    case empty(text: String)
}

class PlaceholderView: UIView {
    
    fileprivate func populate(type: PlaceholderType, buttonAction: (() -> ())? = nil) {
        let view: UIView
        
        switch type {
        case .loading(let text):
            let loadingView = LoadingView.build()
            loadingView.populate(text: text)
            view = loadingView
        case .error(let text, let buttonText):
            let errorView = EmptyOrErrorView.build()
            let image = #imageLiteral(resourceName: "ic_error").withRenderingMode(.alwaysTemplate).tint(with: .primaryColor)
            errorView.showError(text: text, buttonText: buttonText, image: image, buttonAction: buttonAction)
            view = errorView
        case .empty(let text):
            let emptyView = EmptyOrErrorView.build()
            let image = #imageLiteral(resourceName: "ic_empty_list").withRenderingMode(.alwaysTemplate).tint(with: .primaryColor)
            emptyView.showEmpty(text: text, image: image)
            view = emptyView
        }
        
        self.addSubview(view)
        constrain(self, view) { (container, view) in
            view.edges == container.edges
        }
    }
    
}

extension PlaceholderView {
    
    static func build(type: PlaceholderType, buttonAction: (() -> ())? = nil) -> PlaceholderView {
        let view = PlaceholderView()
        view.populate(type: type, buttonAction: buttonAction)
        return view
    }
}
