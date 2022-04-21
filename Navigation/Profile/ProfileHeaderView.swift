//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Завьялов on 20.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var profileAvatarImage: UIImageView = {
        let tempImage = UIImage(named: "cat1.jpg")
        let profileAvatarImage = UIImageView()
        profileAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        profileAvatarImage.clipsToBounds = true
        profileAvatarImage.backgroundColor = .systemBackground
        profileAvatarImage.layer.cornerRadius = 55.0
        profileAvatarImage.layer.borderWidth = 3.0
        profileAvatarImage.layer.borderColor = UIColor.white.cgColor
        profileAvatarImage.image = tempImage
        return profileAvatarImage
    }()
    
    lazy var profileNameLabel: UILabel = {
        let profileNameLabel = UILabel()
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.text = "Santa Cat"
        profileNameLabel.textColor = .black
        profileNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return profileNameLabel
    }()
    
    lazy var profileStatusTextField: UITextField = {
        let profileStatusTextField = UITextField()
        profileStatusTextField.translatesAutoresizingMaskIntoConstraints = false
        profileStatusTextField.text = "Waiting for something..."
        profileStatusTextField.textColor = .gray
        profileStatusTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        profileStatusTextField.isUserInteractionEnabled = false
        return profileStatusTextField
    }()
    
    lazy var showStatusButton: UIButton = {
        let showStatusButton = UIButton()
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.setTitleColor(UIColor.white, for: .normal)
        showStatusButton.layer.cornerRadius = 4.0
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4.0
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return showStatusButton
    }()
    
    @objc private func buttonPressed() {
        print("---------")
        print(profileStatusTextField.text ?? "No text")
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            // Отступ слева - 16pt от левой границы safeArea
            profileAvatarImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            // Отступ сверху - 16pt от верхней границы safeArea
            profileAvatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            // Размер изображения по вертикали - 110pt
            profileAvatarImage.heightAnchor.constraint(equalToConstant: 110.0),
            // Размер изображения по горизонтали - 110pt
            profileAvatarImage.widthAnchor.constraint(equalToConstant: 110.0),
            
            // Отступ слева - 16pt от правой границы изображения
            profileNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImage.trailingAnchor, constant: 16.0),
            profileNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            profileNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            profileStatusTextField.leadingAnchor.constraint(equalTo: profileAvatarImage.trailingAnchor, constant: 16.0),
            // Нижняя граница - 34pt от верха button
            profileStatusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -34.0),
            profileStatusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            showStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            showStatusButton.topAnchor.constraint(equalTo: profileAvatarImage.bottomAnchor, constant: 16.0),
            showStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            // Высота кнопки - 50pt
            showStatusButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupView(){
        addSubview(profileAvatarImage)
        addSubview(profileNameLabel)
        addSubview(profileStatusTextField)
        addSubview(showStatusButton)
        setupLayout()
    }
}
