//
//  HomePageVCViewController.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/30/20.
//

import UIKit

protocol HomePageViewable: class {}

final class HomePageVC: UIViewController, HomePageViewable {
    
    // MARK: - Properties
    
    private var traditionalDataSource: CustomButton = {
        let button = CustomButton(title: "Traditional DataSource 👉🏻")
        button.addTarget(self, action: #selector(didTapTraditionalDataSource), for: .touchUpInside)
        return button
    }()
    
    private var diffableDataSource: CustomButton = {
        let button = CustomButton(title: "Diffable DataSource 👉🏻")
        button.addTarget(self, action: #selector(didTapDiffableDataSource), for: .touchUpInside)
        return button
    }()
    
    private let stackView = UIStackView()
    
    var presenter: HomePagePresentable!

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pick One Option Below"
        
        addStackView()
    }
    
    private func addStackView() {
        stackView.addArrangedSubview(traditionalDataSource)
        stackView.addArrangedSubview(diffableDataSource)
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        view.addSubview(stackView)
        setupStackViewConstraints()
    }
    
    // MARK: - Selectors
    @objc private func didTapTraditionalDataSource() {
        UIView.animate(withDuration: 0.1) {
            self.traditionalDataSource.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            self.traditionalDataSource.transform = .identity
            self.presenter.goToTraditionalDataSource()
        }
    }
    
    @objc private func didTapDiffableDataSource() {
        UIView.animate(withDuration: 0.1) {
            self.diffableDataSource.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            self.diffableDataSource.transform = .identity
            self.presenter.goToDiffableDataSource()
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}
