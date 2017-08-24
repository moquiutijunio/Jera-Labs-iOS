//
//  BaseViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import Cartography
import TPKeyboardAvoiding

protocol BaseViewProtocol: class {
    func addLogoOnNav()
    func addRightBarButton(image: UIImage, block: @escaping () -> Void )
}

class BaseViewController: UIViewController {
    
    lazy var tableView: TPKeyboardAvoidingTableView = self.initializeTableView()
    var tableViewConstraints: [NSLayoutConstraint]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        workArroundToBackButton()
    }
    
    private func workArroundToBackButton() {
        let barButtom = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = barButtom
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func initializeTableView() -> TPKeyboardAvoidingTableView {
        let tableView = TPKeyboardAvoidingTableView()
        view.addSubview(tableView)
        view.sendSubview(toBack: tableView)
        constrain(tableView, view) { (tableView, view) in
            self.tableViewConstraints = tableView.edges == view.edges
        }
        return tableView
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.separatorColor = .separetorColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension BaseViewController: BaseViewProtocol {
    
    func addRightBarButton(image: UIImage, block: @escaping () -> Void ) {
        let rightBarButton = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        _ = rightBarButton.rx.tap
            .subscribe(onNext: { (_) in
                block()
            })
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func addLogoOnNav() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo_jeralabs"))
        self.navigationItem.titleView = imageView
    }
}
