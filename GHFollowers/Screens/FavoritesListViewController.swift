//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/17/21.
//

import UIKit

class FavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
            
        }
    }
}
