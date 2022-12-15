//
//  DatingDetailSegue.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-14.
//

import UIKit

final class DatingDetailSeque: UIStoryboardSegue {
    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}

extension DatingDetailSeque: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DatingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
