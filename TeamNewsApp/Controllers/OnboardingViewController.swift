//
//  OnboardingViewController.swift
//  TeamNewsApp
//
//  Created by Мария Нестерова on 18.03.2024.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    private let nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.backgroundColor = .mainBlue
        nextButton.layer.cornerRadius = 12
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        return nextButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupUI()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        dataSource = self
        delegate = self
        
        pages.append(OnboardingPageViewController(.page1))
        pages.append(OnboardingPageViewController(.page2))
        pages.append(OnboardingPageViewController(.page3))
        pages.append(OnboardingPageViewController(.page4))
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    private func setupUI(){
        
        pageControl.currentPageIndicatorTintColor = .mainBlue
        pageControl.pageIndicatorTintColor = .grayLight
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 60),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }

    @objc private func nextTapped(_ sender: UIButton) {
        if sender.currentTitle == "Get Started" {
            goToLogin()
            return
        }
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: true)
        delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [currentPage], transitionCompleted: true)
    }
    
    private func goToLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == pages.count - 2 {
            nextButton.setTitle("Get Started", for: .normal)
        }
        if currentIndex == pages.count - 1 {
            return nil
        } else {
            return pages[currentIndex + 1]
        }
    }
    
    
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    //How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
    }
}
