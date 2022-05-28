//
//  LogInViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 26.04.2022.
//
// Экран с логинкой:
// Реализовать проверку на пустые поля логина и пароля. Если одно из полей пустое, то при нажатии на кнопку к этому полю
// должно применяться действие. Например: изменение цвета фона, рамки или подергивание.
// Реализовать проверку на количество введенных символов пароля. Если меньше определенного количество, то под полем с паролем
// должен появиться UILabel с предупреждением.
// Установить стандартный логин и пароль. В случае ввода некорректных данных выбрасывать UIAlertController с предупреждением.
// Задача со ★:
// Реализовать проверку валидности email адреса.

import UIKit

class LogInViewController: UIViewController {
    
    private let notify = NotificationCenter.default
    
    private lazy var validationData = ValidationData()
    
    // Альтернативный код scrollView
    // private let scrollView: UIView = {
    // let scrollView = UIView()
    // scrollView.translatesAutoresizingMaskIntoConstraints = false
    // return scrollView
    // }()
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        notify.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notify.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Сдвигаем scrollView.bottom вверх на высоту клавиатуры
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height + 32
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 32, right: 0)
        }
    }
    
    // Восстанавливаем исходное значение scrollView.bottom
    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private let logoImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo.jpg")
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 0.5
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .lightGray
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.lightGray.cgColor
        return $0
    }(UIStackView())
    
    private lazy var userLoginTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.indent(size: 10)
        $0.placeholder = "Email or phone"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .systemGray6
        // $0.layer.borderWidth = 0.5 // Задаем в stackView
        // $0.layer.borderColor = UIColor.lightGray.cgColor // Задаем в stackView
        $0.delegate = self
        $0.addTarget(self, action: #selector(logInButtonAction), for: .editingChanged)
        return $0
    }(UITextField())
    
    private lazy var userPasswordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.indent(size: 10)
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.backgroundColor = .systemGray6
        // $0.layer.borderWidth = 0.5 // Задаем в stackView
        // $0.layer.borderColor = UIColor.lightGray.cgColor // Задаем в stackView
        $0.delegate = self
        $0.addTarget(self, action: #selector(logInButtonAction), for: .editingChanged)
        return $0
    }(UITextField())
    
    private lazy var logInButton: UIButton = {
        let colorButton = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Log In", for: .normal)
        $0.backgroundColor = colorButton
        $0.layer.cornerRadius = 10
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor?.withAlphaComponent(1)
        if $0.isSelected || $0.isHighlighted || $0.isEnabled == false {
            $0.backgroundColor?.withAlphaComponent(0.8)
        }
        $0.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func logInButtonAction() {
        
        guard let enteredEmail = userLoginTextField.text else {return}
        guard let enteredPassword = userPasswordTextField.text else {return}
        
        let login = validEmail(email: enteredEmail)
        let password = validPassword(password: enteredPassword)
        
        if enteredEmail.isEmpty && enteredPassword.isEmpty {
            userLoginTextField.shakeTextField(textField: userLoginTextField)
            userPasswordTextField.shakeTextField(textField: userPasswordTextField)
        } else if enteredEmail.isEmpty {
            userLoginTextField.shakeTextField(textField: userLoginTextField)
        } else if enteredPassword.isEmpty {
            userPasswordTextField.shakeTextField(textField: userPasswordTextField)
        } else {
            if !password && !login {
                invalidDataLabel.text = validationData.invalidEmailAndPassword
                invalidDataLabel.textAlignment = .center
                invalidDataLabel.isHidden = false
                userPasswordTextField.shakeTextField(textField: userPasswordTextField)
                userLoginTextField.shakeTextField(textField: userLoginTextField)
            } else if !password {
                invalidDataLabel.text = validationData.invalidPasswordText
                invalidDataLabel.textAlignment = .left
                invalidDataLabel.isHidden = false
                userPasswordTextField.shakeTextField(textField: userPasswordTextField)
            } else if !login {
                invalidDataLabel.text = validationData.invalidEmailText
                invalidDataLabel.textAlignment = .center
                invalidDataLabel.isHidden = false
                userLoginTextField.shakeTextField(textField: userLoginTextField)
            } else {
                if userLoginTextField.text != validationData.defaultLogin || userPasswordTextField.text != validationData.defaultPassword {
                    logInAlert()
                } else {
                    let profileView = ProfileViewController()
                    self.navigationController?.pushViewController(profileView, animated: true)
                    self.navigationController?.setViewControllers([profileView], animated: true)
                }
            }
        }
        
        
    }
    
    private func logInAlert() {
        let alert = UIAlertController(title: "Error..", message: "Login or password is not correct", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(okAlert)
        present(alert, animated: true)
    }
    
    private lazy var invalidDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 8
        label.contentMode = .scaleToFill
        label.isHidden = true
        return label
    }()
    
    private func validEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let validEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return validEmail.evaluate(with: email)
    }
    
    private func validPassword(password : String) -> Bool {
        let passwordReg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordTesting.evaluate(with: password) && password.count > 6
    }
    
    private func longPassword(password : String) -> Bool {
        return password.count > 6
    }
    
    private func setupLayout() {
        [scrollView].forEach { view.addSubview($0) }
        [contentView].forEach { scrollView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // !!! Обязательно выставить ширину contentView !!!
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [logoImage, stackView, logInButton].forEach { contentView.addSubview($0) }
        [userLoginTextField, userPasswordTextField].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            // logoImage
            logoImage.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            // stackView
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            // firstButton
            userLoginTextField.heightAnchor.constraint(equalToConstant: 50),
            // secondButton
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            // logInButton
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            // !!! Обязательно закрепить нижний элемент к низу contentView !!!
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
