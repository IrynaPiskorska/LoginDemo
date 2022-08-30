//
//  AimTextfield.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 22.08.2022.
//

import Foundation
import UIKit

class AimTextField: UIView {
    
    var isSecure: Bool
    let placeholderText: String
    let txtField = UITextField()
    
    init(isSecure: Bool = false, placeholderText: String) {
        self.isSecure = isSecure
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        configuration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = Constants.Color.secondaryColor
        
        //txtField.placeholder = placeholderText
        txtField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.textColor]
        )
        txtField.textColor = Constants.Color.textColor
        txtField.autocapitalizationType = .none
        txtField.leftViewMode = .always
        txtField.borderStyle = .none
        
        addSubview(txtField)
        addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints{ (make) in
            make.height.equalTo(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        if isSecure {
            txtField.isSecureTextEntry = true
            let viewShowHide = UIView()
            
            let imgShowHide = UIImageView(image: UIImage(named: "eye"))
            imgShowHide.contentMode = .scaleAspectFit
            let btnShowHide = UIButton()
            addSubview(viewShowHide)
            viewShowHide.addSubview(imgShowHide)
            viewShowHide.addSubview(btnShowHide)
            
            viewShowHide.snp.makeConstraints{ (make) in
                make.top.bottom.equalToSuperview()
                make.right.equalToSuperview()
                make.width.equalTo(50)
            }
            
            imgShowHide.snp.makeConstraints{ (make) in
                make.right.left.top.bottom.equalToSuperview().inset(10)
            }
            
            btnShowHide.snp.makeConstraints{ (make) in
                make.right.left.top.bottom.equalToSuperview()
            }
            
            txtField.snp.makeConstraints{ (make) in
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(viewShowHide.snp.left).offset(-5)
            }
            
            btnShowHide.addTarget(self, action: #selector(didTapShowHideButton), for: .touchUpInside)
        } else {
            txtField.snp.makeConstraints{ (make) in
                make.left.right.top.bottom.equalToSuperview()
            }
        }
    }
    @objc private func didTapShowHideButton() {
        txtField.isSecureTextEntry.toggle()
    }
}

