//
//  BrowseDetailViewController.swift
//  TeamNewsApp
//
//  Created by Виталик Молоков on 26.03.2024.
//

import UIKit

class BrowseDetailViewController: UIViewController {
    
    var category: String?
    var article: NewsArticle?
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .systemIndigo
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        displayArticle()
        setupBackButtonNavigation()
    }
    
    private func setupLayout() {
        view.addSubview(newsImageView)
        view.addSubview(titleLabel)
        view.addSubview(categoryLabel)
        view.addSubview(authorLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.topAnchor), 
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), 
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), 
            newsImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), 
            
            
            categoryLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            categoryLabel.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func displayArticle() {
        loadImage(from: article?.urlToImage)
        
        titleLabel.text = article?.title
        descriptionLabel.text = article?.description
        
        if let categoryText = category, !categoryText.isEmpty {
            categoryLabel.text = " \(categoryText.uppercased()) "
        } else {
            categoryLabel.isHidden = true
        }
        authorLabel.text = article?.author
    }

    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            newsImageView.image = UIImage(named: "stock")
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let image = UIImage(data: data) ?? UIImage(named: "stock")
                newsImageView.image = image
            } catch {
                newsImageView.image = UIImage(named: "stock")
                print("Ошибка загрузки изображения: \(error)")
            }
        }
    }
    
    private func setupBackButtonNavigation() {
        let backButtonImage = UIImage(systemName: "arrow.left")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30))
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(customBackAction))
            
            navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func customBackAction() {
        navigationController?.popViewController(animated: true)
    }
}
