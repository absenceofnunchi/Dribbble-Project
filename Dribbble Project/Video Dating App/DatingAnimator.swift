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
        guard let toView = transitionContext.view(forKey: .to),
              let navController = transitionContext.viewController(forKey: .from) as? UINavigationController,
              let fromVC = navController.topViewController as? DatingViewController,
              let imageView = fromVC.userInfoView,
              let toVC = transitionContext.viewController(forKey: .to) as? DatingDetailViewController else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        let originalFrame = imageView.superview?.convert(imageView.frame, to: nil)
        
        containerView.addSubview(toView)
        containerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = originalFrame!
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let duration = transitionDuration(using: transitionContext)
        
        toView.transform = CGAffineTransform(scaleX: 0, y: 0)

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
            imageView.frame = finalFrame
            toView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { success in
            imageView.alpha = 0
            transitionContext.completeTransition(success && !transitionContext.transitionWasCancelled)
        })
    }
}
