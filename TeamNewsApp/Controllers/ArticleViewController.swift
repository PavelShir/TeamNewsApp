//
//  ArticleViewController.swift
//  TeamNewsApp
//
//  Created by Сергей П on 20.03.2024.
//

import UIKit

class ArticleViewController: UIViewController {
    
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
    
    private let paragraphName = "Result"
    
    private let paragraph = """
Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.

For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.

Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page.

Results source: NEP/Edison via Reuters.
"""
    private lazy var articleImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "articleImage")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var backButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var bookmarkButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "bookmark"), for: .normal)
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var shareButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var categoryLabel: UILabel = {
        let element = UILabel()
        element.text = "Politics"
        element.numberOfLines = 1
        element.textColor = .white
        element.font = K.Fonts.categoryFont
        element.backgroundColor = UIColor(named: K.Colors.purplePrimary)
        element.layer.cornerRadius = 16
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var articleNameLabel: UILabel = {
        let element = UILabel()
        element.text = "The latest situation in the presidential election"
        element.numberOfLines = 0
        element.textColor = .white
        element.font = K.Fonts.articleNameFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var autorNameLabel: UILabel = {
        let element = UILabel()
        element.text = "John Doe"
        element.numberOfLines = 1
        element.textColor = .white
        element.font = K.Fonts.authorNameFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var autorLabel: UILabel = {
        let element = UILabel()
        element.text = "Autor"
        element.numberOfLines = 1
        element.textColor = UIColor(named: K.Colors.greyLight)
        element.font = K.Fonts.textFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var paragraphStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 8
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var paragraphNameLabel: UILabel = {
        let element = UILabel()
        element.text = paragraphName
        element.numberOfLines = 0
        element.textColor = UIColor(named: K.Colors.blackPrimary)
        element.font = K.Fonts.authorNameFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var paragraphLabel: UILabel = {
        let element = UILabel()
        element.text = paragraph
        element.numberOfLines = 0
        element.textColor = UIColor(named: K.Colors.greyDarker)
        element.font = K.Fonts.textFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var paragraphNameLabel2: UILabel = {
        let element = UILabel()
        element.text = paragraphName
        element.numberOfLines = 0
        element.textColor = UIColor(named: K.Colors.blackPrimary)
        element.font = K.Fonts.authorNameFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var paragraphLabel2: UILabel = {
        let element = UILabel()
        element.text = paragraph
        element.numberOfLines = 0
        element.textColor = UIColor(named: K.Colors.greyDarker)
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
        
        contentView.addSubview(articleImage)
        contentView.addSubview(backButton)
        contentView.addSubview(bookmarkButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(articleNameLabel)
        contentView.addSubview(autorNameLabel)
        contentView.addSubview(autorLabel)
        contentView.addSubview(paragraphStack)
        
        paragraphStack.addArrangedSubview(paragraphNameLabel)
        paragraphStack.addArrangedSubview(paragraphLabel)
        paragraphStack.addArrangedSubview(paragraphNameLabel2)
        paragraphStack.addArrangedSubview(paragraphLabel2)
    }
}

//MARK: - Setup Constraints

extension ArticleViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 72),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            bookmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 72),
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
            
            shareButton.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor, constant: 24),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            shareButton.heightAnchor.constraint(equalToConstant: 24),
            shareButton.heightAnchor.constraint(equalToConstant: 24),
            
            categoryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 72),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            categoryLabel.heightAnchor.constraint(equalToConstant: 32),
            categoryLabel.widthAnchor.constraint(equalToConstant: 75),
            
            articleNameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            articleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            articleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            articleNameLabel.heightAnchor.constraint(equalToConstant: 54),
            
            autorNameLabel.topAnchor.constraint(equalTo: articleNameLabel.bottomAnchor, constant: 24),
            autorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            autorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            autorNameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            autorLabel.topAnchor.constraint(equalTo: autorNameLabel.bottomAnchor, constant: 0),
            autorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            autorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            autorLabel.heightAnchor.constraint(equalToConstant: 24),
            
            paragraphStack.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 24),
            paragraphStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            paragraphStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            paragraphStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
