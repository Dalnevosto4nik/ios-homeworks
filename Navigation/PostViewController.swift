//
//  PostViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var postTitle: String = "Публикация" // Title по умолчанию
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = postTitle
        view.backgroundColor = .white
        makeBarItem()
        
    }
    private func makeBarItem() {
        let rightBarItem = UIBarButtonItem(title: "Информация", style: .plain, target: self, action: #selector(buttonAction))
        self.navigationItem.title = postTitle
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc private func buttonAction() {
        let infoView = InfoViewController()
        navigationController?.pushViewController(infoView, animated: true)
    }

    
}
