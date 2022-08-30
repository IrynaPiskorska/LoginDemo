//
//  StringExtensions.swift
//  AIMeng
//
//  Created by Iryna Piskorska on 24.08.2022.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: .main, comment: "")
    }
}
