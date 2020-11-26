//
//  ItemCell.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/25/20.
//

import UIKit

class ItemCell: UITableViewCell {
    
    // MARK: Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let containerView = UIView()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure UI
    private func configureUI() {
        selectionStyle = .none
        addContainerView()
        addTitleLabel()
    }
    
    private func addContainerView() {
        addSubview(containerView)
        setupContainerViewConstraints()
        setupContainerViewUI()
    }
        
    private func setupContainerViewUI() {
        containerView.layer.cornerRadius = 5.0
        containerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        setupShadow()
    }
    
    private func setupShadow() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 2.0
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        setupTitleLabelConstraints()
    }
    
    func configureCell(withTitle title: String) {
        titleLabel.text = title
    }
    
    // MARK: Set up constraints
    private func setupContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
}
