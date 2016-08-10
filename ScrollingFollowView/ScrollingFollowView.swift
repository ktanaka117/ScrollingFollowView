//
//  FollowScrollingView.swift
//  FollowScrollingView
//
//  Created by 田中賢治 on 2016/06/13.
//  Copyright © 2016年 田中賢治. All rights reserved.
//

import UIKit

public class ScrollingFollowView: UIView {
    
    private var previousPoint: CGFloat = 0
    
    public private(set) weak var constraint: NSLayoutConstraint!
    
    // In default use, maxFollowPoint should be maxPoint of following to scroll DOWN.
    private var maxFollowPoint: CGFloat!
    // In default use, minFollowPoint should be maxPoint of following to scroll UP.
    private var minFollowPoint: CGFloat!
    
    // These properties are enable to delay showing and hiding ScrollingFollowView.
    private var pointOfStartingHiding: CGFloat = 0
    private var pointOfStartingShowing: CGFloat = 0
    
    private var delayBuffer: CGFloat = 0
    
    public func setup(constraint cons: NSLayoutConstraint, maxFollowPoint: CGFloat, minFollowPoint: CGFloat) {
        constraint = cons
        
        self.maxFollowPoint = -maxFollowPoint
        self.minFollowPoint = minFollowPoint
    }
    
    public func setupDelayPoints(pointOfStartingHiding hidingPoint: CGFloat, pointOfStartingShowing showingPoint: CGFloat) {
        pointOfStartingHiding = -hidingPoint
        pointOfStartingShowing = showingPoint
    }
    
    public func didScrolled(scrollView: UIScrollView) {
        let currentPoint = -scrollView.contentOffset.y
        
        let differencePoint = currentPoint - previousPoint
        let nextPoint = constraint.constant + differencePoint
        let nextDelayBuffer = delayBuffer + differencePoint

        if isTopOrBottomEdge(scrollView) { return }
        
        // Checking delay.
        // pointOfStartingHiding < nextDelayBuffer < pointOfStartingShowing
        if pointOfStartingHiding < nextDelayBuffer && pointOfStartingShowing > nextDelayBuffer {
            
            if nextDelayBuffer < pointOfStartingHiding {
                delayBuffer = pointOfStartingHiding
            } else if nextDelayBuffer > pointOfStartingShowing {
                delayBuffer = pointOfStartingShowing
            } else {
                delayBuffer += differencePoint
            }
            
        } else { // Follow scrolling.
            
            if nextPoint < maxFollowPoint {
                constraint.constant = maxFollowPoint
            } else if nextPoint > minFollowPoint {
                constraint.constant = minFollowPoint
            } else {
                constraint.constant += differencePoint
            }
            
        }
        
        layoutIfNeeded()
        
        previousPoint = currentPoint
    }
    
    private func isTopOrBottomEdge(scrollView: UIScrollView) -> Bool {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height || scrollView.contentOffset.y <= 0 {
            return true
        }
        
        return false
    }
    
}

// MARK: - ManageProperties
extension ScrollingFollowView {
    public func resetPreviousPoint(scrollView: UIScrollView) {
        previousPoint = -scrollView.contentOffset.y
    }
    
    public func resetDelayBuffer(scrollView: UIScrollView) {
        delayBuffer = -scrollView.contentOffset.y
    }
}

// MARK: - ShowAndHide
extension ScrollingFollowView {
    public func show(animated: Bool, duration: Double = 0.2, completionHandler: (()->())? = nil) {
        superview?.layoutIfNeeded()
        
        if animated {
            UIView.animateWithDuration(duration,
                                       animations: { [weak self] in
                                        guard let `self` = self else { return }
                                        self.constraint.constant = self.minFollowPoint
                                        self.superview?.layoutIfNeeded() },
                                       completion: { _ in
                                        completionHandler?()
            })
        } else {
            constraint.constant = minFollowPoint
            superview?.layoutIfNeeded()
            completionHandler?()
        }
    }
    
    public func hide(animated: Bool, duration: Double = 0.2, completionHandler: (()->())? = nil) {
        superview?.layoutIfNeeded()
        
        if animated {
            UIView.animateWithDuration(duration,
                                       animations: { [weak self] in
                                        guard let `self` = self else { return }
                                        self.constraint.constant = self.maxFollowPoint
                                        self.superview?.layoutIfNeeded() },
                                       completion: { _ in
                                        completionHandler?()
            })
        } else {
            constraint.constant = maxFollowPoint
            superview?.layoutIfNeeded()
            completionHandler?()
        }
    }
}
