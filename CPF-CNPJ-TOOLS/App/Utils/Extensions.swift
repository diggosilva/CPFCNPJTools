//
//  Extensions.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ addSubview($0) })
    }
}
