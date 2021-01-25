//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/25/21.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
