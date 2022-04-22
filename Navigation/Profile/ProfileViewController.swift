//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileHeader = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileHeader)
        profileHeader.backgroundColor = .lightGray
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        profileHeader.frame = CGRect(x: 0,
                                     y: view.safeAreaInsets.top,
                                     width: view.frame.width,
                                     height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}
