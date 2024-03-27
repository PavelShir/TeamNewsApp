//
//  LanguageViewController.swift
//  TeamNewsApp
//
//  Created by Сергей П on 20.03.2024.
//

import UIKit

class LanguageViewController: UIViewController {
    
    //MARK: - UI

    private lazy var nameVCLabel: UILabel = {
        let element = UILabel()
        element.text = "Language"
        element.textColor = UIColor(named: K.Colors.blackPrimary)
        element.font = K.Fonts.vcNameFont
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var backButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        element.tintColor = UIColor(named: K.Colors.greyPrimary)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var englishButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("English", for: .normal)
        element.titleLabel?.font = K.Fonts.buttonFont
        element.setImage(UIImage(systemName: "checkmark"), for: .normal)
        element.tintColor = UIColor(white: 1, alpha: 1)
        element.semanticContentAttribute = .forceRightToLeft
        element.titleEdgeInsets = .init(top: 0, left: -200, bottom: 0, right: 0)
        element.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -200)
        element.backgroundColor = UIColor(named: K.Colors.purplePrimary)
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var russianButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Russian", for: .normal)
        element.titleLabel?.font = K.Fonts.buttonFont
//        element.setImage(UIImage(systemName: "checkmark"), for: .normal)
        element.tintColor = UIColor(named: K.Colors.greyDarker)
        element.semanticContentAttribute = .forceRightToLeft
        element.titleEdgeInsets = .init(top: 0, left: -220, bottom: 0, right: 0)
        element.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -200)
        element.backgroundColor = UIColor(named: K.Colors.greyLighter)
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
            
        view.addSubview(nameVCLabel)
        view.addSubview(backButton)
        view.addSubview(englishButton)
        view.addSubview(russianButton)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}

//MARK: - Setup Constraints

extension LanguageViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            nameVCLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            nameVCLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            nameVCLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            nameVCLabel.heightAnchor.constraint(equalToConstant: 32),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            englishButton.topAnchor.constraint(equalTo: nameVCLabel.bottomAnchor, constant: 24),
            englishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            englishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            englishButton.heightAnchor.constraint(equalToConstant: 56),
            
           russianButton.topAnchor.constraint(equalTo: englishButton.bottomAnchor, constant: 16),
           russianButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
           russianButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
           russianButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
