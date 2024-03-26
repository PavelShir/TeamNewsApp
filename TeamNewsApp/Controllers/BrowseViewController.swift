//
//  BrowseViewController.swift
//  TeamNewsApp
//
//  Created by Павел Широкий on 26.03.2024.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private let categories: [(name: String, apiParameter: String)] = [
        ("Random", "general"),
        ("Sports", "sports"),
        ("Gaming", "entertainment"),
        ("Politics", "politics"),
        ("Health", "health"),
        ("Science", "science")
    ]
    
    private var newsArticlesDict: [String: [NewsArticle]] = [:]
    private var buttons = [UIButton]()
    private var activeCategory: String?
    
    // MARK: - UI Elements
    
    private lazy var categorysScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return scrollView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BrowseCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, category) in categories.enumerated() {
            let button = makeCategoryButton(title: category.name, tag: index)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Browse"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover things of this world"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.tintColor = .gray
        imageView.center = glassSearchView.center
        return imageView
    }()
    
    private lazy var newsTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.layer.masksToBounds = true
        textField.leftView = glassSearchView
        textField.leftViewMode = .always
        textField.textColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var glassSearchView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 24))
        return view
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayouts()
        configureCollectionViewLayout()
        setupHideKeyboardOnTap()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(newsTextField)
        glassSearchView.addSubview(searchIcon)
        view.addSubview(categorysScrollView)
        categorysScrollView.addSubview(buttonStackView)
        view.addSubview(collectionView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            newsTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            newsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            newsTextField.heightAnchor.constraint(equalToConstant: 56),
            
            categorysScrollView.topAnchor.constraint(equalTo: newsTextField.bottomAnchor, constant: 20),
            categorysScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categorysScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonStackView.leadingAnchor.constraint(equalTo: categorysScrollView.contentLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: categorysScrollView.contentLayoutGuide.trailingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: categorysScrollView.frameLayoutGuide.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: categorysScrollView.frameLayoutGuide.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: categorysScrollView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 256 + 20)
        ])
    }
    
    private func makeCategoryButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = tag
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
        ])
        return button
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let category = categories[sender.tag]
        changeActiveCategory(to: category.apiParameter)
        updateButtonsAppearance(activeButton: sender)
        newsTextField.text = ""
        newsTextField.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !query.isEmpty else {
            self.newsArticlesDict.removeAll()
            self.collectionView.reloadData()
            return
        }
        
        fetchNews(query: query)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        if newsTextField.text?.isEmpty ?? true {
            searchIcon.isHidden = false
        }
    }
    
    // MARK: - Networking
    
    func fetchNews(category: String? = nil, query: String? = nil) {
        Task {
            do {
                let articles = try await NetworkManager.shared.fetchNews(category: category, query: query)
                let dictKey = query == nil ? (category ?? "Unknown") : "searchResults"
                DispatchQueue.main.async { [weak self] in
                    self?.newsArticlesDict[dictKey] = articles
                    self?.activeCategory = dictKey
                    self?.collectionView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Ошибка при загрузке/поиске новостей: \(error)")
                }
            }
        }
    }
    
    // MARK: - UI Updates
    
    private func configureCollectionViewLayout() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let cellSize = CGSize(width: 256, height: 256)
        
        flowLayout.itemSize = cellSize
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func clearSearchResults() {
        collectionView.reloadData()
        newsArticlesDict.removeAll()
    }
    
    private func changeActiveCategory(to category: String?) {
        activeCategory = category
        
        if let category = category, !category.isEmpty {
            fetchNews(category: category)
        } else {
            clearSearchResults()
        }
        
        if category != "searchResults" {
            updateButtonsAppearance(activeButton: nil)
        }
    }
    
    private func updateButtonsAppearance(activeButton: UIButton?) {
        buttons.forEach { button in
            let isSelected = button == activeButton
            button.setTitleColor(isSelected ? .white : .gray, for: .normal)
            button.backgroundColor = isSelected ? .systemIndigo : .systemGray6
        }
    }
    
    // MARK: - Helper Methods
    
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateButtonsAppearance(activeButton: nil)
        textField.text = ""
        newsArticlesDict.removeAll()
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let activeCategory = activeCategory else { return 0 }
        return newsArticlesDict[activeCategory]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? BrowseCollectionViewCell,
              let activeCategory = activeCategory,
              let article = newsArticlesDict[activeCategory]?[indexPath.row] else {
            fatalError("Could not dequeue NewsCollectionViewCell")
        }
        
        cell.configure(with: article)
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let activeCategory = activeCategory,
              let article = newsArticlesDict[activeCategory]?[indexPath.row] else { return }
        
        let detailVC = BrowseDetailViewController()
        detailVC.article = article
        detailVC.category = activeCategory
        navigationController?.pushViewController(detailVC, animated: true)
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
