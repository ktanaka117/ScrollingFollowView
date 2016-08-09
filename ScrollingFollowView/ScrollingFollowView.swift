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
    
    public weak var constraint: NSLayoutConstraint!
    
    // In default use, maxFollowPoint should be maxPoint of following to scroll DOWN.
    private var maxFollowPoint: CGFloat!
    // In default use, minFollowPoint should be maxPoint of following to scroll UP.
    private var minFollowPoint: CGFloat!
    
    public func setup(constraint cons: NSLayoutConstraint, maxFollowPoint: CGFloat, minFollowPoint: CGFloat) {
        constraint = cons
        
        self.maxFollowPoint = -maxFollowPoint
        self.minFollowPoint = minFollowPoint
    }
    
    public func didScrolled(scrollView: UIScrollView) {
        let currentPoint = -scrollView.contentOffset.y
        
        let differencePoint = currentPoint - previousPoint
        let nextPoint = constraint.constant + differencePoint

        if isTopOrBottomEdge(scrollView) { return }
        
        if nextPoint < maxFollowPoint {
            constraint.constant = maxFollowPoint
        } else if nextPoint > minFollowPoint {
            constraint.constant = minFollowPoint
        } else {
            constraint.constant += differencePoint
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
}

// MARK: - ShowAndHide
extension ScrollingFollowView {
    public func show(animated: Bool, duration: Double = 0.2, completionHandler: (()->())? = nil) {
        superview?.layoutIfNeeded()
        
        if animated {
            constraint.constant = minFollowPoint
            
            CATransaction.begin()
            CATransaction.setCompletionBlock(completionHandler)
            
            UIView.animateWithDuration(duration) { [weak self] in
                guard let `self` = self else { return }
                self.superview?.layoutIfNeeded()
            }
            
            CATransaction.commit()
        } else {
            constraint.constant = minFollowPoint
            superview?.layoutIfNeeded()
            completionHandler?()
        }
    }
    
    public func hide(animated: Bool, duration: Double = 0.2, completionHandler: (()->())? = nil) {
        superview?.layoutIfNeeded()
        
        if animated {
            constraint.constant = maxFollowPoint
            
            CATransaction.begin()
            CATransaction.setCompletionBlock(completionHandler)
            
            UIView.animateWithDuration(duration) { [weak self] in
                guard let `self` = self else { return }
                self.superview?.layoutIfNeeded()
            }
            
            CATransaction.commit()
        } else {
            constraint.constant = maxFollowPoint
            superview?.layoutIfNeeded()
            completionHandler?()
        }
    }
}
