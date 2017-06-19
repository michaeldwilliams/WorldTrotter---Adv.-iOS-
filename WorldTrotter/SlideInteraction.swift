//
//  SlideInteraction.swift
//  WorldTrotter
//
//  Created by Michael Williams on 6/16/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func addInteraction(_ slideInteraction:SlideInteraction) {
        let rightEdgeGR = UIScreenEdgePanGestureRecognizer(target: slideInteraction, action: #selector(SlideInteraction.handlePan(_:)))
        rightEdgeGR.edges = .right
        rightEdgeGR.delegate = slideInteraction
        view.addGestureRecognizer(rightEdgeGR)
        
        let leftEdgeGR = UIScreenEdgePanGestureRecognizer(target: slideInteraction, action: #selector(SlideInteraction.handlePan(_:)))
        leftEdgeGR.edges = .left
        leftEdgeGR.delegate = slideInteraction
        view.addGestureRecognizer(leftEdgeGR)
    }
}

class SlideInteraction: UIPercentDrivenInteractiveTransition {
    
    var tabBarController:UITabBarController!
    var currentlyInteractive = false
    
    func handlePan(_ gr: UIScreenEdgePanGestureRecognizer) {
        print("Panned to relative location: \(gr.translation(in: nil))")
        
        let dX = gr.translation(in: tabBarController.view).x
        let tabCount = tabBarController.viewControllers!.count
        let selectedIndex = tabBarController.selectedIndex
        
        switch gr.state {
        case .began:
            currentlyInteractive = true
            if dX > 0 && selectedIndex > 0 {
                tabBarController.selectedIndex -= 1
            } else if dX <= 0 && selectedIndex < tabCount {
                tabBarController.selectedIndex += 1
            } else {
                currentlyInteractive = false
            }
        case .changed:
            let fraction = abs(dX / tabBarController.view.bounds.width)
            update(fraction)
        case .cancelled:
            cancel()
            currentlyInteractive = false
        case .ended:
            let fraction = abs(dX / tabBarController.view.bounds.width)
            if fraction >= 0.5 {
                finish()
            } else {
                cancel()
            }
            currentlyInteractive = false
        default:
            break
        }
    }
}

extension SlideInteraction: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIScreenEdgePanGestureRecognizer
    }
}
