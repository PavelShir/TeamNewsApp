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
    
    var englishButton = UIButton(title: "English", selected: true)
    var russianButton = UIButton(title: "Russian", selected: false)
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        
        setViews()
        setupConstraints()
    }
    
    //MARK: - ButtonTapped
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func englishButtonTapped(_ sender: UIButton) {
        englishButton.isHidden = true
        russianButton.isHidden = true
        englishButton = UIButton(title: "English", selected: true)
        russianButton = UIButton(title: "Russian", selected: false)
        loadViewIfNeeded()
    }
    
    @objc private func russianButtonTapped(_ sender: UIButton) {
        englishButton.isHidden = true
        russianButton.isHidden = true
        englishButton = UIButton(title: "English", selected: false)
        russianButton = UIButton(title: "Russian", selected: true)
        loadViewIfNeeded()
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
            
        view.addSubview(nameVCLabel)
        view.addSubview(backButton)
        view.addSubview(englishButton)
        view.addSubview(russianButton)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        englishButton.addTarget(self, action: #selector(englishButtonTapped), for: .touchUpInside)
        russianButton.addTarget(self, action: #selector(russianButtonTapped), for: .touchUpInside)
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
}
    
    //MARK: - Language Button select
    
extension UIButton{
    convenience init(title: String, selected: Bool) {
        
        var container = AttributeContainer()
        container.font = K.Fonts.buttonFont
        
        if selected {
            self.init(configuration: .filled())
            container.foregroundColor = UIColor.white
            self.configuration?.image = UIImage(systemName: "checkmark")
            self.configuration?.imagePlacement = .trailing
            self.configuration?.imagePadding = 200
            self.configuration?.baseBackgroundColor = UIColor(named: K.Colors.purplePrimary)
        } else {
            self.init(configuration: .gray())
            container.foregroundColor = UIColor(named: K.Colors.greyDarker)
            self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 240)
            self.configuration?.baseBackgroundColor = UIColor(named: K.Colors.greyLighter)
        }

        self.configuration?.attributedTitle = AttributedString(title, attributes: container)
        self.configuration?.background.cornerRadius = 12
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
    


