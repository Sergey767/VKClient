//
//  CustomAnimator.swift
//  Vkontakte
//
//  Created by Сергей on 22.10.2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.7
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else { return }
        
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        source.view.layer.position = CGPoint(x: 0, y: 0)
        destination.view.layer.position = CGPoint(x: 0, y: 0)
        
        transitionContext.containerView.addSubview(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width, y: 0)
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8, animations: {
                let rotation = CGAffineTransform(rotationAngle: .pi / 2)
                let translation = CGAffineTransform(translationX: -source.view.bounds.width, y: 0)
                source.view.transform = rotation.concatenating(translation)
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                let rotation = CGAffineTransform(rotationAngle: -.pi / 2)
                let translation = CGAffineTransform(translationX: source.view.bounds.width, y: 0)
                destination.view.transform = rotation.concatenating(translation)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.5, animations: {
                destination.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished &&
                !transitionContext.transitionWasCancelled)
        }
    }
}

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.7
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else { return }
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
               
        source.view.layer.position = CGPoint(x: 0, y: 0)
        destination.view.layer.position = CGPoint(x: 0, y: 0)
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        let rotation = CGAffineTransform(rotationAngle: .pi / 2)
        let translation = CGAffineTransform(translationX: -source.view.bounds.width, y: 0)
        destination.view.transform = rotation.concatenating(translation)
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.8, animations: {
                destination.view.transform = .identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                let rotation = CGAffineTransform(rotationAngle: -.pi / 2)
                let translation = CGAffineTransform(translationX: source.view.bounds.width, y: 0)
                source.view.transform = rotation.concatenating(translation)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                source.view.transform = CGAffineTransform(translationX: source.view.bounds.width, y: 0)
            })
            
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished &&
                !transitionContext.transitionWasCancelled)
        }
    }
}

