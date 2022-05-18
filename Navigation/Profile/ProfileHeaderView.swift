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
        setupLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var statusText = String()
    private lazy var avatarImagePosition = avatarImageView.layer.position
    private var isAvatarImageOpen = false
    
    private lazy var avatarView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        // $0.frame = UIScreen.main.bounds
        $0.backgroundColor = .black
        // $0.isHidden = true
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    private lazy var avatarImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "cat1.jpg")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 55
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.isUserInteractionEnabled = true
        // $0.addGestureRecognizer(tapAvatarGesture)
        return $0
    }(UIImageView())
    
    private lazy var closeAvatarImageButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "multiply.circle.fill")?.withTintColor(colorSet), for: .normal)
        $0.alpha = 0.0
        $0.clipsToBounds = false
        $0.imageView?.layer.transform = CATransform3DMakeScale(1.8, 1.8, 1.8)
        $0.addTarget(self, action: #selector(tapToCloseAvatarAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var fullNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Santa Cat"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return $0
    }(UILabel())
    
    private lazy var statusLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Waiting for something..."
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isUserInteractionEnabled = false
        return $0
    }(UILabel())
    
    private lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = colorSet
        $0.setTitle("Set status", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 10
        // $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        // $0.layer.shadowRadius = 4
        // $0.layer.shadowColor = UIColor.black.cgColor
        // $0.layer.shadowOpacity = 0.7
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func buttonAction() {
        statusLabel.text = statusText
        statusTextField.text = ""
        self.endEditing(true)
    }
    
    private lazy var statusTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.indent(size: 10)
        $0.placeholder = "Set your status.."
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 10
        $0.delegate = self
        $0.addTarget(self, action: #selector(statusTextChanges), for: .editingChanged)
        return $0
    }(UITextField())
    
    @objc private func statusTextChanges() {
        statusText = statusTextField.text!
    }
    
    private func setupGestures() {
        let tapToOpenAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tapToOpenAvatarAction))
        let tapToCloseAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tapToCloseAvatarAction))
        if !isAvatarImageOpen {
            isAvatarImageOpen = true
            avatarImageView.addGestureRecognizer(tapToOpenAvatarGesture)
        } else {
            isAvatarImageOpen = false
            avatarImageView.addGestureRecognizer(tapToCloseAvatarGesture)
        }
    }
    
    @objc private func tapToOpenAvatarAction() {
        avatarImagePosition = avatarImageView.layer.position
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) { [self] in
            
            self.avatarView.alpha = 0.8
            self.avatarImageView.center = avatarView.center
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            self.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0) {
                self.closeAvatarImageButton.alpha = 1
                self.setupGestures()
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func tapToCloseAvatarAction() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.closeAvatarImageButton.alpha = 0
            self.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0) {
                self.avatarView.alpha = 0.0
                self.avatarImageView.layer.position = self.avatarImagePosition
                self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: 110, height: 110)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.width / 2
                self.setupGestures()
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setupLayout(){
        [fullNameLabel, statusLabel, setStatusButton, statusTextField, avatarView, avatarImageView, closeAvatarImageButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            // extView
            avatarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            // avatarImageView
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            //closeAvatarImageButton
            closeAvatarImageButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            closeAvatarImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            //closeAvatarImageButton.heightAnchor.constraint(equalToConstant: 110),
            // closeAvatarImageButton.widthAnchor.constraint(equalToConstant: 110),
            // fullNameLabel
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            // statusLabel
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -64),
            // statusTextField
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            // setStatusButton
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 28),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - задаем отступ в UITextField
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

// MARK: - UITextFieldDelegate

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
