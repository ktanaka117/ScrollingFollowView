//
//  FollowScrollingViewController.swift
//  FollowScrollingViewController
//
//  Created by 田中賢治 on 2016/06/13.
//  Copyright © 2016年 田中賢治. All rights reserved.
//

import UIKit

public class ScrollingFollowView: UIView {
    
    private var previousPoint: CGFloat = 0
    
    public weak var constraint: NSLayoutConstraint!
    
    private var minPoint: CGFloat!
    private var maxPoint: CGFloat = 0
    
    public func setup(constraint cons: NSLayoutConstraint, isIncludingStatusBarHeight: Bool) {
        constraint = cons
        
        if isIncludingStatusBarHeight {
            minPoint = -frame.size.height - UIApplication.sharedApplication().statusBarFrame.height
        } else {
            minPoint = -frame.size.height
        }
    }
    
    public func didScrolled(scrollView: UIScrollView) {
        let currentPoint = -scrollView.contentOffset.y
        
        let differencePoint = currentPoint - previousPoint
        let nextPoint = constraint.constant + differencePoint

        if isTopOrBottomEdge(currentPoint, scrollView: scrollView) { return }
        
        if nextPoint < minPoint {
            constraint.constant = minPoint
        } else if nextPoint > maxPoint {
            constraint.constant = maxPoint
        } else {
            constraint.constant += differencePoint
        }
        
        previousPoint = currentPoint
    }
    
    private func isTopOrBottomEdge(currentPoint: CGFloat, scrollView: UIScrollView) -> Bool {
        if -currentPoint >= scrollView.contentSize.height - scrollView.bounds.size.height || -currentPoint <= 0 {
            return true
        }
        
        return false
    }
    
}
