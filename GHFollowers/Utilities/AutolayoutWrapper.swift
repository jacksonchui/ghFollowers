//
//  AutolayoutWrapper.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/20/21.
//

import UIKit

@propertyWrapper public struct UsesAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
