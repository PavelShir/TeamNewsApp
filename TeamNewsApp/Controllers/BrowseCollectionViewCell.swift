//
//  BrowseCollectionViewCell.swift
//  TeamNewsApp
//
//  Created by Виталик Молоков on 26.03.2024.
//

import UIKit

class BrowseCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 3
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 3
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -32), 
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), 
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoryLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8), 
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func loadImage(from urlString: String?) {
        Task {
            guard let urlString = urlString, let url = URL(string: urlString) else {
                self.newsImageView.image = UIImage(named: "stock")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    self.newsImageView.image = image
                } else {
                    self.newsImageView.image = UIImage(named: "stock")
                }
            } catch {
                print("Failed to load image: \(error)")
                self.newsImageView.image = UIImage(named: "stock")
            }
        }
    }
    
    func configure(with article: NewsArticle) {
        titleLabel.text = article.title
        categoryLabel.text = article.category
        loadImage(from: article.urlToImage)
    }
}
