//
//  BlueViewController.swift
//  WorldTrotter
//
//  Created by Michael Williams on 6/14/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController, UIViewControllerTransitioningDelegate {

    let modalTransition = ModalTransition()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return modalTransition
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
    }
    
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
