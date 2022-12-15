//
//  DatingAnimator.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-14.
//

import UIKit

final class DatingAnimator: NSObject {
    
}

extension DatingAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to),
              let navController = transitionContext.viewController(forKey: .from) as? UINavigationController,
              let fromVC = navController.topViewController as? DatingViewController,
              let toVC = transitionContext.viewController(forKey: .to) as? DatingDetailViewController else {
            transitionContext.completeTransition(false)
            return
        }
        
        transitionContext.containerView.addSubview(toView)
        toView.frame = fromView.frame
        toView.alpha = 0
        toView.layoutIfNeeded()
        
        let imageView = fromVC.imageView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            imageView?.frame = finalFrame
            
            toView.frame = finalFrame
            toView.alpha = 1
        }, completion: { success in
            transitionContext.completeTransition(success && !transitionContext.transitionWasCancelled)
        })
    }
}
