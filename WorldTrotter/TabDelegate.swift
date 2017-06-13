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
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return slideTransition
    }



}
