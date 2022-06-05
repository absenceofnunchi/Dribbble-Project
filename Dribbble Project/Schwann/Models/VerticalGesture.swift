//
//  VerticalGesture.swift
//  Dribbble Project
//
//  Created by J on 2022-06-05.
//

import Foundation
import UIKit.UIGestureRecognizer

class VerticalGesture: UIPanGestureRecognizer {
    private var touch: UITouch!
    private var currentView: UIView!
    private var currentSuperview: UIView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let firstTouch = touches.first, let currentView = self.view, let currentSuperview = currentView.superview else { return }
        self.touch = firstTouch
        self.currentView = currentView
        self.currentSuperview = currentSuperview
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        var center = self.currentView.center
        let currentLocation = self.touch.location(in: self.currentSuperview)
        let previousLocation = self.touch.previousLocation(in: self.currentSuperview)
        let yTranslation = currentLocation.y - previousLocation.y
        center.y += yTranslation
        self.view!.center = center
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        for subview in self.currentSuperview.subviews {
            // this goes through all the sibling views including the non-calendar-event views i.e. calendar dates, calendar frame, etc
            // so make sure to sort those out
            if subview != self.currentView! && self.currentView!.frame.intersects(subview.frame) {
                var center = self.currentView.center
                let isHigher = subview.center.y >= center.y
                // isHigher >= 0 means the current view that you've selected is located higher
                // than the overlapping view below
                if isHigher {
                    center = CGPoint(x: subview.center.x, y: subview.center.y - self.currentView.bounds.height)
                    self.view!.center = center
                } else {
                    center = CGPoint(x: subview.center.x, y: subview.center.y + self.currentView.bounds.height)
                    self.view!.center = center
                }
            }
        }
        super.touchesEnded(touches, with: event)
    }
}
