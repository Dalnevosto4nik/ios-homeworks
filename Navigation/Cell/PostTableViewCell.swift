//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Сергей Завьялов on 27.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    weak var delegate: PostTableViewCellDelegate?
    
    private var postIndex = 0
    private var postLikes = 0
    private var postViews = 0
    private var isLiked = false
    
    private let postView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 0
        $0.layer.borderWidth = 0
        $0.layer.borderColor = UIColor.black.cgColor
        return $0
    }(UIView())
    
    private let authorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 3
        $0.textAlignment = .justified
        return $0
    }(UILabel())
    
    private let backImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.alpha = 0.4
        return $0
    }(UIImageView())
    
    private let postImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let likesLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    
    private let viewsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupGestures()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        let tapLikesGesture = UITapGestureRecognizer(target: self, action: #selector(likesAction))
        likesLabel.addGestureRecognizer(tapLikesGesture)
    }
    
    @objc func likesAction() {
        if !isLiked {
            postLikes += 1
            isLiked = true
        } else {
            postLikes -= 1
            isLiked = false
        }
        likesLabel.text = "Likes: \(postLikes)"
        delegate?.likePostPressed(index: postIndex, likes: postLikes, isLike: isLiked)
    }
    
    func postLiked(likes: Int, isLike: Bool) {
        postLikes = likes
        isLiked = isLike
    }
    
    func postViewed(viewes: Int) {
        postViews = viewes
    }
    
    func setupCell(index: Int, post: PostModel) {
        postIndex = index
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        backImageView.image = UIImage(named: post.image)
        postImageView.image = UIImage(named: post.image)
        postLikes = post.likes
        isLiked = post.isLiked
        postViews = post.views
        likesLabel.text = "Likes: \(postLikes)"
        viewsLabel.text = "Views: \(postViews)"
    }

    private func setupLayout() {
        let inset: CGFloat = 16
        let aspectRatio: CGFloat = (postImageView.image?.size.height ?? 1) / (postImageView.image?.size.width ?? 1)
        
        [postView, authorLabel, descriptionLabel, backImageView, postImageView, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            // postView
            postView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            // authorLabel
            authorLabel.topAnchor.constraint(equalTo: postView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -inset),
            // backImageView
            backImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            backImageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            backImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            backImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: aspectRatio),
            // postImageView
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            postImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: aspectRatio),
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -inset),
            // likesLabel
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -inset),
            // viewsLabel
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -inset)
        ])
    }
}

extension PostTableViewCell: ProfileViewControllerDataSource {
    func postViewed(index: Int, viewes: Int) {
    }
    
    func postLiked(index: Int, likes: Int) {
    }
}

