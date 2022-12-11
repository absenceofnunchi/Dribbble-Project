//
//  EmployeeSegue.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-10.
//

import UIKit

final class EmployeeSegue: UIStoryboardSegue {
    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}

extension EmployeeSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return EmployeePresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return EmployeeDismissAnimator()
    }
}
