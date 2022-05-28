//
//  Delegate.swift
//  Navigation
//
//  Created by Сергей Завьялов on 27.05.2022.
//

import Foundation

protocol ProfileViewControllerDataSource: AnyObject {
    func postViewed(viewes: Int)
    func postLiked(likes: Int, isLike: Bool)
}
