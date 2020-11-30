//
//  CustomButton.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/30/20.
//

import UIKit

class CustomButton: UIButton {
    let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        setTitleColor(.black, for: .normal)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 10.0
    }
}
