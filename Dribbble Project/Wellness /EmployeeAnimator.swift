//
//  EmployeeAnimator.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-10.
//

import UIKit

final class EmployeePresentAnimator: NSObject {

}

extension EmployeePresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let navController = transitionContext.viewController(forKey: .from) as? UINavigationController,
              let fromVC = navController.topViewController as? WellnessViewController,
              let targetView = fromVC.elementView1,
              let viewX = targetView.subviews.filter({ $0.tag == 100 }).first,
              let stackView = targetView.subviews.filter({ $0 is UIStackView }).first,
              let toVC = transitionContext.viewController(forKey: .to) as? EmployeeViewController,
              let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        let finalFrame = transitionContext.finalFrame(for: toVC)
        let duration = transitionDuration(using: transitionContext)
        
        transitionContext.containerView.addSubview(toView)
        
        toView.frame = fromVC.view.frame
        toView.alpha = 0
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration) {
            viewX.transform = CGAffineTransform(scaleX: 10, y: 10)
            stackView.transform = CGAffineTransform(rotationAngle: -15 / 180 * CGFloat.pi).scaledBy(x: 1.5, y: 1.5)
            stackView.alpha = 0
            toView.frame = finalFrame
            toView.alpha = 1
        } completion: { success in
            transitionContext.completeTransition(success && !transitionContext.transitionWasCancelled)
        }
    }
}

final class EmployeeDismissAnimator: NSObject {
    
}

extension EmployeeDismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let navController = transitionContext.viewController(forKey: .to) as? UINavigationController,
              let toVC = navController.topViewController as? WellnessViewController,
              let targetView = toVC.elementView1,
              let viewX = targetView.subviews.filter({ $0.tag == 100 }).first,
              let stackView = targetView.subviews.filter({ $0 is UIStackView }).first else {
            transitionContext.completeTransition(false)
            return
        }
        
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration) {
            viewX.transform = .identity
            stackView.transform = .identity
        } completion: { success in
            transitionContext.completeTransition(success && !transitionContext.transitionWasCancelled)
        }
    }
}
