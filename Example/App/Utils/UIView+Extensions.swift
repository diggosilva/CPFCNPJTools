//
//  UIView+Extensions.swift
//  Example
//
//  Created by Diggo Silva on 07/04/26.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ addSubview($0) })
    }
}
