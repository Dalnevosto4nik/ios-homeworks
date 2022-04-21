//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstProfileHeaderView = ProfileHeaderView(frame: CGRect(x: 0,
                                                                y: view.safeAreaInsets.top,
                                                                width: view.frame.width,
                                                                height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
                                                               )
        )
        firstProfileHeaderView.backgroundColor = .lightGray
        view.addSubview(firstProfileHeaderView)
    }
}
