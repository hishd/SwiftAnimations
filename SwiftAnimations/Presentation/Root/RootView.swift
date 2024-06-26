//
//  RootView.swift
//  SwiftAnimations
//
//  Created by Hishara Dilshan on 2024-06-26.
//

import Foundation
import UIKit

final class RootView: UIView {
    
    var loginButtonWidthAnchor: NSLayoutConstraint?
    
    lazy var title: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = .systemFont(ofSize: 28, weight: .semibold)
        text.text = "Welcome Back"
        return text
    }()
    
    lazy var userEmailField: UITextField = {
        let field = UITextField()
        let attributedPlaceholder = NSAttributedString(string: "Enter email", attributes: [.foregroundColor: UIColor.gray])
        field.textColor = .black
        field.borderStyle = .roundedRect
        field.backgroundColor = .white
        field.keyboardType = .emailAddress
        field.attributedPlaceholder = attributedPlaceholder
        return field
    }()
    
    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        let attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [.foregroundColor: UIColor.gray])
        field.textColor = .black
        field.borderStyle = .roundedRect
        field.backgroundColor = .white
        field.attributedPlaceholder = attributedPlaceholder
        return field
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .backgroundGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var cloud1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.fill")
        imageView.tintColor = .colorCloud
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.stopAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupSubViews() {
        self.backgroundColor = .backgroundLightBlue
        
        self.addSubview(title)
        title.centerX(inView: self, topAnchor: self.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        
        self.addSubview(userEmailField)
        userEmailField.setHeight(of: 48)
        userEmailField.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 40, paddingRight: 40)
        userEmailField.centerX(inView: self, topAnchor: title.bottomAnchor, paddingTop: 60)
        
        self.addSubview(passwordField)
        passwordField.setHeight(of: 48)
        passwordField.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 40, paddingRight: 40)
        passwordField.centerX(inView: self, topAnchor: userEmailField.bottomAnchor, paddingTop: 26)
        
        self.loginButtonWidthAnchor = NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
        self.addSubview(loginButton)
        loginButton.setHeight(of: 48)
        loginButton.centerX(inView: self, topAnchor: passwordField.bottomAnchor, paddingTop: 26)
        loginButtonWidthAnchor?.isActive = true
        
        self.insertSubview(cloud1, belowSubview: userEmailField)
        cloud1.setDimensions(height: 140, width: 220)
        cloud1.centerX(inView: self, topAnchor: self.loginButton.bottomAnchor, paddingTop: 60)
        
        self.addSubview(resetButton)
        resetButton.setDimensions(height: 40, width: 100)
        resetButton.centerX(inView: self)
        resetButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 32)
        
        self.addSubview(activityIndicator)
        activityIndicator.setDimensions(height: 40, width: 40)
        activityIndicator.centerY(inView: loginButton, leftAnchor: loginButton.leftAnchor, paddingLeft: 10)
    }
}
