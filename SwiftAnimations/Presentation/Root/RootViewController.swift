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
        
        animateButtonTransformation()
        
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
    }
    
    func animateClouds() {
        let cloud1CenterStart = containerView.cloud1.center.x - (self.view.bounds.width * 0.75)
        let cloud1CenterEnd = containerView.cloud1.center.x + (self.view.bounds.width * 0.75)
        
        containerView.cloud1.center.x = cloud1CenterStart
        containerView.cloud1.alpha = 0.5
        UIView.animate(withDuration: 5.0, delay: 0.5, options: [.repeat]) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.containerView.cloud1.center.x = cloud1CenterEnd
            strongSelf.containerView.cloud1.alpha = 1
        }
    }
}

extension RootViewController {
    func setActions() {
        self.containerView.resetButton.addAction(UIAction(handler: { [weak self] _ in
            self?.animateTitle()
            self?.animateTextFields()
            self?.animateButton()
        }), for: .touchUpInside)
    }
}
