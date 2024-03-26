//
//  TermsViewController.swift
//  TeamNewsApp
//
//  Created by Сергей П on 20.03.2024.
//

import UIKit

class ProfileTermsViewController: UIViewController {
    
    //MARK: - UI - Scroll View
    
    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.showsHorizontalScrollIndicator = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var contentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - UI
    
    private let terms = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. 

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.
"""
    
    private lazy var nameVCLabel: UILabel = {
        let element = UILabel()
        element.text = "Terms & Conditions"
        element.textColor = UIColor(named: K.Colors.blackPrimary)
        element.font = K.Fonts.vcNameFont
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var backButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        element.tintColor = UIColor(named: K.Colors.greyPrimary)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var termsLabel: UILabel = {
        let element = UILabel()
        element.text = terms
        element.numberOfLines = 0
        element.textColor = UIColor(named: K.Colors.greyPrimary)
        element.font = K.Fonts.textFont
        element.textAlignment = .left
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        contentView.addSubview(nameVCLabel)
        contentView.addSubview(backButton)
        contentView.addSubview(termsLabel)
    }
}

//MARK: - Setup Constraints

extension ProfileTermsViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
            nameVCLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameVCLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            nameVCLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            nameVCLabel.heightAnchor.constraint(equalToConstant: 32),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            termsLabel.topAnchor.constraint(equalTo: nameVCLabel.bottomAnchor, constant: 20),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
