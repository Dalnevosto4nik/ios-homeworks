//
//  DetailPostViewDelegate.swift
//  Navigation
//
//  Created by Сергей Завьялов on 26.05.2022.
//

import Foundation

protocol DetailPostViewDelegate: AnyObject {
    func postViewed(index: Int, viewes: Int)
    func likeDetailPostPressed(index: Int, likes: Int, isLike: Bool)
}
