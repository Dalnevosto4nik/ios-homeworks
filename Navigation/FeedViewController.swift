//
//  FeedViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.04.2022.
//

import UIKit

// Создаем структуру Post cо свойством title: String
struct Post {
    var title : String
}

// Создаем FeedViewController
class FeedViewController: UIViewController {
    // Создаем объект типа Post передаваемый в PostViewController
    var post = Post(title: "My post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeButton()
    }
    
    private func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Post", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func buttonAction() {
        let postView = PostViewController()
        postView.postTitle = post.title
        navigationController?.pushViewController(postView, animated: true)
    }
}
