//
//  GFAlertView.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/17/21.
//

import UIKit

class GFAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 16
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        backgroundColor     = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }

}
