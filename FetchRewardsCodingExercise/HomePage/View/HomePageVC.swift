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
    
    private var traditionalDataSource: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapTraditionalDataSource), for: .touchUpInside)
        button.setTitle("Traditional DataSource 👉🏻", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private var diffableDataSource: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapDiffableDataSource), for: .touchUpInside)
        button.setTitle("Diffable DataSource 👉🏻", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        presenter.goToTraditionalDataSource()
    }
    
    @objc private func didTapDiffableDataSource() {
        presenter.goToDiffableDataSource()
    }
    
    // MARK: - Setup Constraints
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
}
