//
//  RootViewController.swift
//  SwiftAnimations
//
//  Created by Hishara Dilshan on 2024-06-26.
//

import Foundation
import UIKit

final class RootViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    private let viewModel: RootViewModel
    private let containerView = RootView()
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Required initialiser error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(containerView)
        containerView.fillSuperView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateTitle()
        animateTextFields()
        animateButton()
        animateClouds()
        
        setActions()
    }
}

//MARK: Animating widgets
extension RootViewController {
    func animateTitle() {
        let optionsRepeat: UIView.AnimationOptions = [.repeat, .autoreverse, .curveEaseOut]
        let optionsNone: UIView.AnimationOptions = []
        
        animateTitleWithOptions(options: optionsNone)
        
        func animateTitleWithOptions(options: UIView.AnimationOptions) {
            let titleCenterX = containerView.title.center.x - self.view.bounds.width
            containerView.title.center.x = titleCenterX
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: options) { [weak self] in
                guard let strongSelf = self else {return}
                let titleCenterX = strongSelf.containerView.title.center.x + strongSelf.view.bounds.width
                strongSelf.containerView.title.center.x = titleCenterX
            }
            
        }
    }
    
    func animateTextFields() {
        let userNameCenterX = containerView.userEmailField.center.x - self.view.bounds.width
        containerView.userEmailField.center.x = userNameCenterX
        
        let passwordCenterX = containerView.passwordField.center.x - self.view.bounds.width
        containerView.passwordField.center.x = passwordCenterX
        
        UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
            guard let strongSelf = self else {return}
            let fieldCenterX = strongSelf.containerView.userEmailField.center.x + strongSelf.view.bounds.width
            strongSelf.containerView.userEmailField.center.x = fieldCenterX
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3) { [weak self] in
            guard let strongSelf = self else {return}
            let fieldCenterX = strongSelf.containerView.passwordField.center.x + strongSelf.view.bounds.width
            strongSelf.containerView.passwordField.center.x = fieldCenterX
        }
    }
    
    func animateButton() {
        
        animateButtonSpringEffectFromBottom()
        
        func animateButtonAlpha() {
            containerView.loginButton.alpha = 0
            
            UIView.animate(withDuration: 1.0) { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.containerView.loginButton.alpha = 1
            }
        }
        
        func animateButtonColor() {
            containerView.loginButton.backgroundColor = .backgroundLightBlue
            
            UIView.animate(withDuration: 1.5) { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.containerView.loginButton.backgroundColor = .backgroundGreen
            }
        }
        
        func animateButtonTransformation() {
            let initialTransformState = CGAffineTransform(scaleX: 0, y: 0)
            containerView.loginButton.transform = initialTransformState
            
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.containerView.loginButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        func animateButtonSpringEffectFromBottom() {
            let newCenter = self.containerView.loginButton.center.y + 50
            self.containerView.loginButton.center.y = newCenter
            self.containerView.loginButton.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.containerView.loginButton.center.y -= 50
                strongSelf.containerView.loginButton.alpha = 1
            }
        }
    }
    
    func animateClouds() {
        let cloud1CenterStart = 0 - self.containerView.cloud1.frame.width
        let cloud1CenterEnd = self.view.bounds.width + self.containerView.cloud1.frame.width
        
        containerView.cloud1.center.x = cloud1CenterStart
        containerView.cloud1.alpha = 0.5
        
        UIView.animate(withDuration: 5.0, delay: 0) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.containerView.cloud1.center.x = cloud1CenterEnd
            strongSelf.containerView.cloud1.alpha = 1
        } completion: { [weak self] _ in
            self?.animateClouds()
        }
    }
}

extension RootViewController {
    func startLoading() {
        self.containerView.loginButtonWidthAnchor?.isActive = false
        self.containerView.loginButtonWidthAnchor?.constant = 160
        self.containerView.loginButtonWidthAnchor?.isActive = true
        
        self.containerView.activityIndicator.startAnimating()
        
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.0
        ) {
            self.containerView.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0,
        options: [], animations: {
            self.containerView.loginButton.backgroundColor = UIColor.darkGray
        }, completion: nil)
    }
    
    func stopLoading() {
        self.containerView.loginButtonWidthAnchor?.isActive = false
        self.containerView.loginButtonWidthAnchor?.constant = 120
        self.containerView.loginButtonWidthAnchor?.isActive = true
        
        self.containerView.activityIndicator.stopAnimating()
        
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.0
        ) {
            self.containerView.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0,
        options: [], animations: {
            self.containerView.loginButton.backgroundColor = .backgroundGreen
        }, completion: nil)
    }
    
    func setActions() {
        self.containerView.resetButton.addAction(UIAction(handler: { [weak self] _ in
            self?.animateTitle()
            self?.animateTextFields()
            self?.animateButton()
        }), for: .touchUpInside)
        
        self.containerView.loginButton.addTarget(self, action: #selector(performAction), for: .touchUpInside)
    }
    
    @objc func performAction() {
        startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.stopLoading()
        }
//        UIView.animate(
//            withDuration: 1.5,
//            delay: 0,
//            usingSpringWithDamping: 0.2,
//            initialSpringVelocity: 0.0
//        ) {
//            self.containerView.loginButton.bounds.size.width += 80
//        }
        
//        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0,
//        options: [], animations: {
//            self.containerView.loginButton.center.y += 60.0
//            self.containerView.loginButton.backgroundColor = UIColor.red
//        }, completion: nil)
    }
}
