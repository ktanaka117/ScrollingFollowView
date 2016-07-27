//
//  ViewController.swift
//  ScrollingFollowView
//
//  Created by 田中賢治 on 2016/07/05.
//  Copyright © 2016年 田中賢治. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navBarScrollingFollowView: ScrollingFollowView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBarTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        navBarScrollingFollowView.setup(constraint: navBarTopConstraint, isIncludingStatusBarHeight: true)
        
        navBarScrollingFollowView.backgroundColor = UIColor.redColor()
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell") else { fatalError("Empty Cell") }
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.contentOffset.y > 200 {
            navBarScrollingFollowView.show(true) {
                print("show")
            }
        } else {
            navBarScrollingFollowView.hide(true) {
                print("hide")
            }
        }
        
        navBarScrollingFollowView.resetPreviousPoint(tableView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        navBarScrollingFollowView.didScrolled(scrollView)
    }
}
