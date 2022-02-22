//
//  UIstackView+Ex.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 18.01.22.
//

import Foundation
import UIKit


extension UIStackView {
    func addArrangedSubviews (_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
