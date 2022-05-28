//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Сергей Завьялов on 26.05.2022.
//

import Foundation

protocol PostTableViewCellDelegate: AnyObject {
    func likePostPressed(index: Int, likes: Int, isLike: Bool)
}
