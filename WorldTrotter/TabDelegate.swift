//
//  TabDelegate.swift
//  WorldTrotter
//
//  Created by Michael Williams on 6/13/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TabDelegate: NSObject, UITabBarControllerDelegate {
    
    private let slideTransition = SlideTransition()
    private let slideInteraction = SlideInteraction()
    
    init(tabBarController:UITabBarController) {
        super.init()
        tabBarController.addInteraction(slideInteraction)
        slideInteraction.tabBarController = tabBarController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideTransition
    }

    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return slideInteraction.currentlyInteractive ? slideInteraction : nil
    }


}
