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
        photoImageView.isUserInteractionEnabled = true
        
        return photoImageView
    }()
    
    private let nameField: UITextField = {
        let nameField = UITextField()
        nameField.font = .systemFont(ofSize: 16, weight: .semibold)
        nameField.textColor = .black
        nameField.returnKeyType = .done
        nameField.layer.cornerRadius = 12
        
        return nameField
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
        view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
        photoImageView.clipsToBounds = true
        
    }
    
    private func configure() {
        user = UserStorageManager.shared.getUserData()
        nameField.text = user?.name
        mailLabel.text = user?.mail
        if let photo = user?.photoName {
            photoImageView.image = UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(photo).path)
        }
        nameField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        photoImageView.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileLabel)
        view.addSubview(photoImageView)
        view.addSubview(nameField)
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
            
            nameField.bottomAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            nameField.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 24),
            nameField.trailingAnchor.constraint(equalTo: profileLabel.trailingAnchor),
            
            mailLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8),
            mailLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            mailLabel.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
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
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        print("present")
        present(picker, animated: true)
        print("present")
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        UserStorageManager.shared.updateUserPhoto(photoName: imageName)
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        dismiss(animated: true) {
            self.configure()
            self.view.setNeedsLayout()
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .grayLight
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = nil
        guard let newName = textField.text else { return }
        UserStorageManager.shared.updateUserName(name: newName)
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
