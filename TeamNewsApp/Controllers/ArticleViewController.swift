//
//  ArticleViewController.swift
//  TeamNewsApp
//
//  Created by Сергей П on 20.03.2024.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var category: String?
    var article: NewsArticle?
    
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
    
    private lazy var articleImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
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
        let element = PaddingLabel(withInsets: 8, 8, 16, 16)
        element.text = ""
        element.numberOfLines = 1
        element.textColor = .white
        element.font = K.Fonts.categoryFont
        element.backgroundColor = UIColor(named: K.Colors.purplePrimary)
        element.layer.cornerRadius = 16
        element.textAlignment = .center
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var articleNameLabel: UILabel = {
        let element = UILabel()
        element.text = ""
        element.numberOfLines = 0
        element.textColor = .white
        element.font = K.Fonts.articleNameFont
        element.textAlignment = .left
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: 0)
        element.layer.shadowOpacity = 0.7
        element.layer.shadowRadius = 3
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var autorNameLabel: UILabel = {
        let element = UILabel()
        element.text = ""
        element.numberOfLines = 1
        element.textColor = .white
        element.font = K.Fonts.authorNameFont
        element.textAlignment = .left
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: 0)
        element.layer.shadowOpacity = 0.7
        element.layer.shadowRadius = 3
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
        element.layer.shadowColor = UIColor.white.cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: 0)
        element.layer.shadowOpacity = 0.7
        element.layer.shadowRadius = 1
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
        element.text = ""
        element.numberOfLines = 0
        element.textColor = UIColor(named: K.Colors.blackPrimary)
        element.font = K.Fonts.authorNameFont
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var paragraphLabel: UILabel = {
        let element = UILabel()
        element.text = ""
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
        displayArticle()
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func bookmarkButtonTapped(_ sender: UIButton) {
    }
    
    @objc private func shareButtonButton(_ sender: UIButton) {
    }
    
    //MARK: - Load Article
    
    private func displayArticle() {
        loadImage(from: article?.urlToImage)
        
        articleNameLabel.text = article?.title
        paragraphLabel.text = article?.description
        
        if let categoryText = category, !categoryText.isEmpty {
            categoryLabel.text = " \(categoryText.uppercased()) "
        } else {
            categoryLabel.isHidden = true
        }
        autorNameLabel.text = article?.author
    }
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            articleImage.image = UIImage(named: "stock")
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let image = UIImage(data: data) ?? UIImage(named: "stock")
                articleImage.image = image
            } catch {
                articleImage.image = UIImage(named: "stock")
                print("Ошибка загрузки изображения: \(error)")
            }
        }
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
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonButton), for: .touchUpInside)
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
            articleImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            articleImage.heightAnchor.constraint(equalTo: articleImage.widthAnchor),
            
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
            
            articleNameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            articleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            articleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
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

//MARK: - Label with padding

class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
