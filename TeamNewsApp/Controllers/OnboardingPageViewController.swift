//
//  OnboardingPageViewController.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 18.03.2024.
//

import UIKit

enum OnboardingPage: String {
    case page1 = "anim1"
    case page2 = "anim2"
    case page3 = "anim3"
    case page4 = "anim4"
}

class OnboardingPageViewController: UIViewController {
    
    private let onboardingDescriptionName = ["Tailored News Experience", "Seamless Navigation", "Personalized Bookmarks", "Immersive Reading Experience"]
    private let onboardingDescriptionText = ["Welcome to our news app! Customize your news feed by selecting categories of interest. Whether you're into politics, technology or sports, we've got you covered.", "Explore diverse news topics effortlessly. Easily switch between news categories right from the main page. Interface lets you navigate your interests with just a tap.", "Keep track of your favorite stories with our bookmark feature. Found an article you love? Save it to your bookmarks tab for quick access later.", "Enjoy an uninterrupted reading experience as you delve into each story. Our app provides a seamless platform for you to immerse yourself in the news that matters."]
    
    private let gifImageView: UIImageView  = {
        let gifImageView = UIImageView()
        gifImageView.contentMode = .scaleAspectFit
        gifImageView.layer.cornerRadius = 12
        gifImageView.layer.borderColor = UIColor.grayLight.cgColor
        gifImageView.layer.borderWidth = 2
        
        return gifImageView
    }()
    
    private let descriptionNameLabel: UILabel = {
        let descriptionNameLabel = UILabel()
        descriptionNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        descriptionNameLabel.textColor = .black
        descriptionNameLabel.textAlignment = .center
        
        return descriptionNameLabel
    }()
    
    private let descriptionTextLabel: UILabel = {
        let descriptionTextLabel = UILabel()
        descriptionTextLabel.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionTextLabel.textColor = .gray
        descriptionTextLabel.textAlignment = .center
        descriptionTextLabel.numberOfLines = 0
        
        return descriptionTextLabel
    }()
    
    init(_ page: OnboardingPage) {
        super.init(nibName: nil, bundle: nil)
        setupContent(page: page)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImageView.clipsToBounds = true
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(gifImageView)
        view.addSubview(descriptionNameLabel)
        view.addSubview(descriptionTextLabel)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            gifImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.41),
            gifImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            descriptionNameLabel.topAnchor.constraint(equalTo: gifImageView.bottomAnchor, constant: 82),
            descriptionNameLabel.centerXAnchor.constraint(equalTo: gifImageView.centerXAnchor),
            
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionNameLabel.bottomAnchor, constant: 20),
            descriptionTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupContent(page: OnboardingPage) {
        
        guard let gifPath = Bundle.main.path(forResource: page.rawValue, ofType: "gif") else { return }
        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else { return }
        guard let gifImage = UIImage.gifImageWithData(gifData) else { return }
        
        gifImageView.image = gifImage
        
        switch page {
        case .page1:
            descriptionNameLabel.text = onboardingDescriptionName[0]
            descriptionTextLabel.text = onboardingDescriptionText[0]
        case .page2:
            descriptionNameLabel.text = onboardingDescriptionName[1]
            descriptionTextLabel.text = onboardingDescriptionText[1]
        case .page3:
            descriptionNameLabel.text = onboardingDescriptionName[2]
            descriptionTextLabel.text = onboardingDescriptionText[2]
        case .page4:
            descriptionNameLabel.text = onboardingDescriptionName[3]
            descriptionTextLabel.text = onboardingDescriptionText[3]
        }
    }
}

extension UIImage {
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let frameCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }

        return UIImage.animatedImage(with: images, duration: 0.0)
    }
}
