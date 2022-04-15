//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.04.2022.
//


import UIKit

class MainTabBarController: UITabBarController {
    
    // Создаем FeedViewController и ProfileViewController..
   
    let feedView = FeedViewController()
    let profileView = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }

    private func setupControllers() {
        
        // Добавляем в UITabBarController два UINavigationController (лента пользователя и его профиль)
        // и назначаем им FeedViewController и ProfileViewController как root view controller.
        let feedNavigationController = UINavigationController(rootViewController: feedView)
        let profileNavigationController = UINavigationController(rootViewController: profileView)
        
        // Меняем Tab Bar Item у добавленных контроллеров, добавив заголовок и картинку..
        feedView.tabBarItem.title = "Лента"
        feedView.tabBarItem.image = UIImage(systemName: "house.fill")
        feedView.navigationItem.title = "Лента"
        
        profileView.tabBarItem.title = "Профиль"
        profileView.tabBarItem.image = UIImage(systemName: "person.fill")
        profileView.navigationItem.title = "Профиль"
        
        viewControllers = [feedNavigationController, profileNavigationController]
        
    }
}

