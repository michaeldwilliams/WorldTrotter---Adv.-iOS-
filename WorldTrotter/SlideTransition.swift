//
//  SlideTransition.swift
//  WorldTrotter
//
//  Created by Michael Williams on 6/13/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {

    enum Direction {
        case left
        case right
    }
    
    var animationDirection = Direction.left
    let animationDuration:TimeInterval = 0.35
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration

    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from) else {
                preconditionFailure("Transition started with mission context info!")
        }
        container.addSubview(toView)
        
        toView.transform = offscreenTransform(for: toView, inContainer: container, isReversed: true)
        
        let moveViewsClosure = {
            toView.transform = .identity
            fromView.transform = self.offscreenTransform(for: fromView, inContainer: container, isReversed: false)
        }
        
        let cleanUpClosure = { (didComplete:Bool) in
            toView.transform = .identity
            fromView.transform = .identity
            transitionContext.completeTransition(true)
        }
        
        UIView.animate(withDuration: animationDuration, animations: moveViewsClosure, completion: cleanUpClosure)
    }
    
    private func offscreenTransform(for view: UIView, inContainer container: UIView, isReversed: Bool) -> CGAffineTransform {
        var transform = view.transform
        switch (animationDirection, isReversed) {
        case (.left, false), (.right, true):
            transform = transform.translatedBy(x: -container.bounds.width, y: 0)
            animationDirection = .right
        case (.right, false), (.left, true):
            transform = transform.translatedBy(x: container.bounds.width, y: 0)
            animationDirection = .left
        }
        transform = transform.scaledBy(x: 0.875, y: 0.9)
        return transform
    }
    
}
