//
//  AimLabel.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 22.08.2022.
//

import Foundation
import UIKit

class AimLabel: UILabel {
    enum Style {
        case header
        case subheader
        case regular
        case small
    }
    
    let labelText: String
    let style: Style
    init(style: Style = .regular, labelText: String) {
        self.style = style
        self.labelText = labelText
        super.init(frame: .zero)
        configuration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        text = labelText
        textColor = Constants.Color.textColor
        switch style {
        case .header:
            textAlignment = .center
            font = .systemFont(ofSize: 24, weight: .bold)
        case .subheader:
            textAlignment = .center
            font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            textAlignment = .justified
            font = .systemFont(ofSize: 12)
        default:
            textAlignment = .justified
            font = .systemFont(ofSize: 14)
        }
    }
}
