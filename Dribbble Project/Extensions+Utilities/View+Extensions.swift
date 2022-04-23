//
//  View+Extensions.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import UIKit

extension UIView {
    func setFill(_ inset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: inset),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset),
        ])
    }
}
