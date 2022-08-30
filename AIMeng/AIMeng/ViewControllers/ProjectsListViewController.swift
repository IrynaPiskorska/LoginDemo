//
//  ProjectsListViewController.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 21.08.2022.
//

import UIKit

class ProjectsListViewController: UIViewController {
    
    var viewModel: ProjectsListViewModel
    let lblPlaceholder = AimLabel(style: .header, labelText: "Placeholder")
    
    
    init(viewModel: ProjectsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .white
        setUpElements()
    }
    
    func setUpElements() {
        view.addSubview(lblPlaceholder)
        
        lblPlaceholder.snp.makeConstraints{ (make) in
            make.height.equalTo(44)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
