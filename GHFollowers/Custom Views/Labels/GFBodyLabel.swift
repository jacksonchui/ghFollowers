//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/17/21.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        textColor                           = .secondaryLabel
        font                                = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth          = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor                 = 0.75
        lineBreakMode                       = .byWordWrapping
        //configure body lines in the view
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
