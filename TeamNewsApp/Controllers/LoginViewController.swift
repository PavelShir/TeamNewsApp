//
//  LoginViewController.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 20.03.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    private enum Mode {
        case signUp
        case signIn
        
        mutating func toggle() {
            switch self {
            case.signUp:
                self = .signIn
            case .signIn:
                self = .signUp
            }
        }
    }
    
    private var mode: Mode
    
    private let loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        loginLabel.textColor = .black
        
        return loginLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        return descriptionLabel
    }()
    
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField(picName: "person", isSecure: false)
        userNameTextField.placeholder = "Username"
        
        return userNameTextField
    }()
    
    private let mailTextField: UITextField = {
        let mailTextField = UITextField(picName: "envelope", isSecure: false)
        mailTextField.placeholder = "Email Address"
        mailTextField.keyboardType = .emailAddress
        
        return mailTextField
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField(picName: "lock", isSecure: true)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .newPassword
        
        return passwordTextField
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let repeatPasswordTextField = UITextField(picName: "lock", isSecure: true)
        repeatPasswordTextField.placeholder = "Repeat Password"
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.textContentType = .newPassword
        repeatPasswordTextField.addTarget(self, action: #selector(repeatedPasswordChanged), for: .editingChanged)
        
        return repeatPasswordTextField
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton(type: .system)
        signInButton.backgroundColor = .mainBlue
        signInButton.layer.cornerRadius = 12
        signInButton.tintColor = .white
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        return signInButton
        
    }()
    
    private let signInLabel: UILabel = {
        let signInLabel = UILabel()
        signInLabel.font = .systemFont(ofSize: 16, weight: .regular)
        signInLabel.textColor = .darkGray
        
        return signInLabel
    }()
    
    private lazy var signInBottomButton: UIButton = {
        let signInBottomButton = UIButton(type: .system)
        signInBottomButton.setTitle("Sign In", for: .normal)
        signInBottomButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        signInBottomButton.tintColor = .black
        signInBottomButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
        
        return signInBottomButton
    }()
    
    private let passwordCompareLabel: UILabel = {
        let passwordCompareLabel = UILabel()
        passwordCompareLabel.font = .systemFont(ofSize: 12, weight: .regular)
        passwordCompareLabel.textAlignment = .right
        passwordCompareLabel.isHidden = true
        
        return passwordCompareLabel
    }()
    
    init() {
        if UserStorageManager.shared.getUserData() != nil {
            mode = .signIn
        } else {
            mode = .signUp
        }
        
        super.init(nibName: nil, bundle: nil)
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        userNameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let mainStack: UIStackView
        if mode == .signIn {
            mainStack = UIStackView(arrangedSubviews: [mailTextField, passwordTextField, signInButton])
            loginLabel.text = "Welcome Back 👋"
            descriptionLabel.text = "I am happy to see you again. You can continue where you left off by logging in"
            signInButton.setTitle("Sign In", for: .normal)
            signInBottomButton.setTitle("Sign Up", for: .normal)
            signInLabel.text = "Don't have an account?"
        } else {
            mainStack = UIStackView(arrangedSubviews: [userNameTextField, mailTextField, passwordTextField, repeatPasswordTextField])
            loginLabel.text = "Welcome to NewsToDay"
            descriptionLabel.text = "Hello, I guess you are new around here. You can start using the application after sign up"
            signInButton.setTitle("Sign Up", for: .normal)
            signInBottomButton.setTitle("Sign In", for: .normal)
            signInLabel.text = "Already have an account?"
            view.addSubview(passwordCompareLabel)
            view.addSubview(signInButton)
        }
        mainStack.axis = .vertical
        mainStack.spacing = 16
        let bottomStack = UIStackView(arrangedSubviews: [signInLabel, signInBottomButton])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 5
        view.addSubview(loginLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(mainStack)
        view.addSubview(bottomStack)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            mainStack.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            bottomStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        if mode == .signUp {
            NSLayoutConstraint.activate([
                passwordCompareLabel.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),
                passwordCompareLabel.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
                signInButton.topAnchor.constraint(equalTo: passwordCompareLabel.bottomAnchor, constant: 10),
                signInButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
                signInButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor)
            ])
        }
    }
    
    @objc private func signInTapped(_ sender: UIButton) {
        if mode == .signIn {
            mailTextField.endEditing(true)
            passwordTextField.endEditing(true)
            if UserStorageManager.shared.login(mail: mailTextField.text ?? "", password: passwordTextField.text ?? "") {
                
                let tabBarVC = TabBarViewController()
                tabBarVC.modalPresentationStyle = .fullScreen
                present(tabBarVC, animated: true)
                print("go to Main Page")
                
            } else {
                let alert = UIAlertController(title: "Wrong email or password", message: "Please, check it carefully and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        } else {
            if passwordCompareLabel.textColor == .green {
                userNameTextField.endEditing(true)
                mailTextField.endEditing(true)
                passwordTextField.endEditing(true)
                UserStorageManager.shared.saveNewUser(User(name: userNameTextField.text ?? "", mail: mailTextField.text ?? "", password: passwordTextField.text ?? ""))
                
                let tabBarVC = TabBarViewController()
                tabBarVC.modalPresentationStyle = .fullScreen
                present(tabBarVC, animated: true)
                print("go to Main Page")
            } else {
                let alert = UIAlertController(title: "Passwords doesn't match", message: "Please, try to repeat new password again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }
    }
    
    @objc private func switchMode(_ sender: UIButton) {
        mode.toggle()
        configure()
        setupUI()
        view.setNeedsLayout()
    }
    
    @objc private func repeatedPasswordChanged(_ sender: UITextField) {
        if passwordTextField.text != "" {
            passwordCompareLabel.isHidden = false
            if passwordTextField.text == repeatPasswordTextField.text {
                passwordCompareLabel.textColor = .green
                passwordCompareLabel.text = "Passwords match"
            } else {
                passwordCompareLabel.textColor = .red
                passwordCompareLabel.text = "Passwords doesn't match"
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becameActive()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignActive()
    }

}

extension UITextField {
    
    convenience init(picName: String, isSecure: Bool) {
        self.init()
        returnKeyType = .done
        font = .systemFont(ofSize: 16, weight: .regular)
        textColor = .darkGray
        backgroundColor = .grayLight
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(systemName: picName)
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)
        
        leftView = container
        leftViewMode = .always
        leftView?.tintColor = .darkGray
        
        if isSecure {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            let showPasswordButton = UIButton(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            showPasswordButton.imageView?.contentMode = .scaleAspectFit
            showPasswordButton.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
            container.addSubview(showPasswordButton)
            
            rightView = container
            rightViewMode = .always
            rightView?.tintColor = .darkGray
        }
        
    }
    
    @objc private func showPasswordTapped(_ sender: UIButton) {
        isSecureTextEntry.toggle()
    }
    
    func becameActive() {
        backgroundColor = .white
        textColor = .black
        layer.borderColor = UIColor.mainBlue.cgColor
        layer.borderWidth = 1
        leftView?.tintColor = .mainBlue
        rightView?.tintColor = .mainBlue
    }
    
    func resignActive() {
        backgroundColor = .grayLight
        textColor = .darkGray
        layer.borderWidth = 0
        leftView?.tintColor = .darkGray
        rightView?.tintColor = .darkGray
    }
}
