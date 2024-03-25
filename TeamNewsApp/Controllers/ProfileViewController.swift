//
//  ProfileViewController.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 19.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var user: User?
    
    private let profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.text = "Profile"
        profileLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        profileLabel.textColor = .black
        
        return profileLabel
    }()
    
    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.image = UIImage(systemName: "plus")
        photoImageView.tintColor = .gray
        
        return photoImageView
    }()
    
    private let nameLabel: UITextField = {
        let nameLabel = UITextField()
        nameLabel.placeholder = "Your Name"
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .black
        
        return nameLabel
    }()
    
    private let mailLabel: UILabel = {
        let mailLaibel = UILabel()
        mailLaibel.text = "hello@gmail.com"
        mailLaibel.font = .systemFont(ofSize: 14, weight: .regular)
        mailLaibel.textColor = .darkGray
        
        return mailLaibel
    }()
    
    private let languageButton: UIButton = {
        let languageButton = UIButton(title: "Language", picName: "greaterthan")
        
        return languageButton
    }()
    
    private let termsButton: UIButton = {
        let termsButton = UIButton(title: "Terms & Conditions", picName: "greaterthan")
        termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        
        return termsButton
    }()
    
    private let signOutButton: UIButton = {
        let signOutButton = UIButton(title: "Sign Out", picName: "rectangle.portrait.and.arrow.forward")
        
        return signOutButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
        photoImageView.clipsToBounds = true
        
    }
    
    private func configure() {
        user = UserStorageManager.shared.getUserData()
        nameLabel.text = user?.name
        mailLabel.text = user?.mail
        photoImageView.image = user?.photo?.image
        let tap = UITapGestureRecognizer(target: self, action: #selector(photoTapped))
        photoImageView.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileLabel)
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
        view.addSubview(mailLabel)
        view.addSubview(languageButton)
        view.addSubview(termsButton)
        view.addSubview(signOutButton)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            photoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 32),
            photoImageView.widthAnchor.constraint(equalToConstant: 72),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: profileLabel.leadingAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: profileLabel.trailingAnchor),
            
            mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            mailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            mailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            languageButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 44),
            languageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            signOutButton.centerXAnchor.constraint(equalTo: languageButton.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalTo: languageButton.widthAnchor),
            
            termsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -28),
            termsButton.centerXAnchor.constraint(equalTo: signOutButton.centerXAnchor),
            termsButton.widthAnchor.constraint(equalTo: signOutButton.widthAnchor)
        ])
    }
    
    @objc private func termsTapped(_ sender: UIButton) {
        let termsVC = TermsViewController()
        termsVC.modalPresentationStyle = .fullScreen
        present(termsVC, animated: true)
    }
    
    @objc private func photoTapped(_ sender: UITapGestureRecognizer? = nil) {
        
        //Тут будет выбор фото для профиля
        
        print("photo tapped")
    }
}

extension UIButton {
    convenience init(title: String, picName: String) {
        self.init(frame: .zero)
        backgroundColor = .grayLight
        layer.cornerRadius = 12
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.textColor = .gray
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        let indicatorImageView = UIImageView(image: UIImage(systemName: picName))
        indicatorImageView.tintColor = .gray
        indicatorImageView.contentMode = .scaleAspectFit
        
        addSubview(titleLabel)
        addSubview(indicatorImageView)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            indicatorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            indicatorImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        if picName == "greaterthan" {
            indicatorImageView.contentMode = .scaleToFill
            indicatorImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
            indicatorImageView.widthAnchor.constraint(equalTo: indicatorImageView.heightAnchor, multiplier: 0.5).isActive = true
        } else {
            indicatorImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            indicatorImageView.widthAnchor.constraint(equalTo: indicatorImageView.heightAnchor).isActive = true
        }
    }
}
