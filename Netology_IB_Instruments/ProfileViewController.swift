//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Сергей Завьялов on 01.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = UIScreen.main.bounds.width
        let screenHeght = UIScreen.main.bounds.height
        if let newView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView {
            newView.frame = CGRect(x: 16, y: 32, width: screenWidth - 32, height: screenHeght - 32)
            view.addSubview(newView)
        }
    }
}
