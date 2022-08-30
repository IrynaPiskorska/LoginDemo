//
//  AimButton.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 21.08.2022.
//

import Foundation
import UIKit

class AimButton: UIButton {
    
    enum Style {
        case primary
        case secondary
    }
    
    let title: String
    let style: Style
    
    init(style: Style = .primary, title: String) {
        self.style = style
        self.title = title
        super.init(frame: .zero)
        configuration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        backgroundColor = Constants.Color.primaryColor
        layer.cornerRadius = 25.0
        tintColor = .white
        setTitle(title, for: .normal)
    }
}

