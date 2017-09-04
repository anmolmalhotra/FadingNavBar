//
//  DetailController.swift
//  NavBar
//
//  Created by Anmol Malhotra on 04/09/17.
//  Copyright © 2017 Anmol Malhotra. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var controllerTitle: String? {
        didSet {
            navigationItem.title = controllerTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
}





