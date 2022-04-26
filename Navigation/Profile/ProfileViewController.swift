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
        setupLayout()
    }
    
    private let profileHeader: ProfileHeaderView = {
    let profileHeader = ProfileHeaderView()
        profileHeader.backgroundColor = .lightGray
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()
    
    private lazy var newButton: UIButton = {
        let newButton = UIButton()
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.backgroundColor = .systemBlue
        newButton.setTitle("New button", for: .normal)
        newButton.setTitleColor(UIColor.white, for: .normal)
        newButton.addTarget(self, action: #selector(pressNewButton), for: .touchUpInside)
        return newButton
    }()
    
    @objc private func pressNewButton() {
        print("Нажата New Button")
    }

    private func setupLayout() {
        view.addSubview(profileHeader)
        view.addSubview(newButton)
      
        NSLayoutConstraint.activate([
            // profileHeader
            profileHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeader.heightAnchor.constraint(equalToConstant: 220),
            // newButton
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
